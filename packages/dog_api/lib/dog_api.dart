library dog_api;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';


/// Exceptions
class DogRequestNot200Failure implements Exception {}
class DogRequestFailure implements Exception {}
class DogRequestGeneralFailure implements Exception {}
class DogRequestNoData implements Exception {}
class DogRequestInvalidData implements Exception {}




///
/// Dart API Client which wraps the [Dog API](https://dog.ceo/dog-api/documentation/).
///
///

class DogApiClient {


  static final BaseOptions _options = BaseOptions(
      baseUrl: 'https://dog.ceo',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
  final Dio _dio;

  DogApiClient({Dio? dio}):
        _dio = dio ?? Dio(_options)
  ;




  /// Returns an array of all the images from a breed, e.g. hound
  Future<List<String>> breed(String breed) async {
    final Response response;

    try {
      response = await _dio.request('/api/breed/$breed/images');
      debugPrint('$response');
    } on DioError catch (e) {

      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        debugPrint('{$e.response.data}');
        throw DogRequestNot200Failure();

      } else {

        debugPrint('{$e.message}');
        throw DogRequestFailure();
      }
    } catch (e) {
      debugPrint('$e');

      throw DogRequestGeneralFailure();
    }

    if (response.data == null) {
      throw DogRequestNoData();
    }
    if (response.data["status"] != 'success') {
      throw DogRequestInvalidData();
    }

    if (response.data["message"] is List<dynamic>){
      final list = response.data["message"] as List<dynamic>;
      if (list.where((element) => element is! String).isNotEmpty) {
        throw DogRequestInvalidData();
      }


      return list.map((e) => e as String).toList();
    } else {

      throw DogRequestInvalidData();
    }

  }


}

