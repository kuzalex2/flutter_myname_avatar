import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dog_api/dog_api.dart';
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
  group('DogApiClient', () {
    late DogApiClient dogApiClient;


    setUp(() {
      dogApiClient = DogApiClient();
    });



    group('constructor', () {
      test('default constructor', () {
        expect(DogApiClient(), isNotNull);
      });
    });

    group('breed', () {
      test('non-existing breed', () async {
        expect(
              () async => dogApiClient.breed('somebreed'),
          throwsA(isA<DogRequestNot200Failure>()),
        );
      });
      test('existing breed', () async {
        expect(
          await dogApiClient.breed('hound'),
          isA<List<String>>(),
        );
      });
    });


  });

  group('MockDogApiClient', () {
    late DogApiClient dogApiClient;
    late Dio dio;


    setUp(() {
      dio = MockDio();
      dogApiClient = DogApiClient(dio: dio);
    });





    group('breed', () {
      test('non-existing breed', () async {
        expect(
              () async => dogApiClient.breed('somebreed'),
          throwsA(isA<DogRequestGeneralFailure>()),
        );
      });

    });


  });
}
