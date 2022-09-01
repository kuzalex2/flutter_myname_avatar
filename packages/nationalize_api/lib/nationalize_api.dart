library nationalize_api;


export 'model.dart';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'model.dart';


/// Exceptions
class NationalizeRequestNot200Failure implements Exception {}
class NationalizeRequestFailure implements Exception {}
class NationalizeRequestGeneralFailure implements Exception {}
class NationalizeRequestNoData implements Exception {}
class NationalizeRequestInvalidData implements Exception {}




///
/// Dart API Client which wraps the [Nationalize API](https://nationalize.io).
///
///

class NationalizeApiClient {


  static final BaseOptions _options = BaseOptions(
    baseUrl: 'https://api.nationalize.io',
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  final Dio _dio;

  NationalizeApiClient({Dio? dio}):
        _dio = dio ?? Dio(_options)
  ;




  /// Predict the nationality of a name
  Future<NationalizeResponse> predict(String name) async {

    final Response response;
    try {
    // ?name=michael
      response = await _dio.get('/',queryParameters: {'name': name});
      debugPrint('$response');
    } on DioError catch (e) {

      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        debugPrint('{$e.response.data}');
        throw NationalizeRequestNot200Failure();

      } else {

        debugPrint('{$e.message}');
        throw NationalizeRequestFailure();
      }
    } catch (e) {
      debugPrint('$e');

      throw NationalizeRequestGeneralFailure();
    }

    if (response.data == null) {
      throw NationalizeRequestNoData();
    }
    if (response.data["name"] != name) {
      throw NationalizeRequestInvalidData();
    }



    if (response.data["country"] is List<dynamic>){
      final list = response.data["country"] as List<dynamic>;

      /// check response data
      ///
      if (list.where((element) => element is! Map || element['country_id'] is! String || element['probability'] is! double).isNotEmpty) {
        throw NationalizeRequestInvalidData();
      }

      return NationalizeResponse(
        name: response.data["name"] ,
        countries: list.map((element) => CountryProbability(country: element['country_id'], probability: element['probability'])).toList()
        // countries: List<Map<String,dynamic>>.filled(100, {'country_id':'ru','probability':0.5}).map((element) => CountryProbability(country: element['country_id'], probability: element['probability'])).toList()
      );

    } else {

      throw NationalizeRequestInvalidData();
    }

  }


}


