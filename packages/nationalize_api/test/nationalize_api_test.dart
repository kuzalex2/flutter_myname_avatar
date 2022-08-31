import 'package:flutter_test/flutter_test.dart';

import 'package:nationalize_api/nationalize_api.dart';



import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockDio extends Mock
    implements Dio {


  @override
  Future<Response<T>> request<T>(
      String path, {
        data,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
        Options? options,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      })
  {
    throw Exception("invalid");
  }

}


void main() {
  group('NationalizeApiClient', () {
    late NationalizeApiClient apiClient;


    setUp(() {
      apiClient = NationalizeApiClient();
    });



    group('constructor', () {
      test('default constructor', () {
        expect(NationalizeApiClient(), isNotNull);
      });
    });

    group('predict', () {
      test('empty throws NationalizeRequestNot200Failure', () async {
        expect(
              () async => apiClient.predict(''),
          throwsA(isA<NationalizeRequestNot200Failure>()),
        );
      });
      test('predict alex', () async {
        expect(
           await apiClient.predict('alex'),
          isA<NationalizeResponse>(),
        );
      });

    });


  });

  group('Mock NationalizeApiClient', () {
    late NationalizeApiClient apiClient;
    late Dio dio;


    setUp(() {
      dio = MockDio();
      apiClient = NationalizeApiClient(dio: dio);
    });





    group('predict', () {
      test('network error', () async {
        expect(
              () async => apiClient.predict('alex'),
          throwsA(isA<NationalizeRequestGeneralFailure>()),
        );
      });

    });


  });
}
