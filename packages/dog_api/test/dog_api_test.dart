import 'package:flutter_test/flutter_test.dart';

import 'package:dog_api/dog_api.dart';



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
}
