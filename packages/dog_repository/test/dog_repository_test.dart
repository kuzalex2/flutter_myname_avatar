import 'package:dog_api/dog_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:dog_repository/dog_repository.dart';


class MockDogApiClient extends Mock
    implements DogApiClient {
  @override
  Future<List<String>> breed(String breed) async {
    throw DogRequestGeneralFailure();
  }
}

void main() {


  group('WeatherRepository', () {
    late DogApiClient mockApiClient;
    late DogRepository repository;

    setUp(() {
      mockApiClient = DogApiClient();
      repository = DogRepository(
        dogApiClient: mockApiClient,
      );
    });

    group('constructor', () {
      test('instantiates internal DogApiClient when not injected', () {
        expect(DogRepository(), isNotNull);
      });
    });

    test('existing breed', () async {
      expect(
        await repository.dogPictureUrl(),
        isA<String>(),
      );
    });

  });

  group('WeatherRepository2', () {
    late DogApiClient mockApiClient;
    late DogRepository repository;

    setUp(() {
      mockApiClient = MockDogApiClient();
      repository = DogRepository(
        dogApiClient: mockApiClient,
      );
    });



    test('emulate network error', () async {
      expect(
            () async => await repository.dogPictureUrl(),
        throwsA(isA<DogRequestGeneralFailure>()),
      );

    });

  });
}
