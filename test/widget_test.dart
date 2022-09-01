import 'package:bloc_test/bloc_test.dart';
import 'package:dog_api/dog_api.dart';
import 'package:flutter_myname_avatar/bloc/person_name_cubit/person_name_cubit.dart';
import 'package:flutter_myname_avatar/repository/repository.dart';
import 'package:flutter_myname_avatar/repository/store_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nationalize_api/nationalize_api.dart';



class StoreRepositoryMock extends Mock implements StoreRepository {

}

class DogApiClientMock extends Mock implements DogApiClient {

}

class NationalizeApiClientMock extends Mock implements NationalizeApiClient {

}

class MockRepo extends Mock implements Repository {

  late final DogApiClient dogApiClient ;
  late final NationalizeApiClient nationalizeApiClient;
  late final StoreRepository storeRepository;


  @override
  init() async {
    dogApiClient = DogApiClient();
    nationalizeApiClient = NationalizeApiClient();

    storeRepository = StoreRepository(db: SaveLoadMock());
    await storeRepository.init();

  }
}

void main() {


  group('AppCubit', () {
    late PersonNameCubit cubit ;
    late MockRepo repository;


    //
    setUp(() async {
      repository = MockRepo();
      await repository.init();
      cubit = PersonNameCubit(repository, nickName: '');
    });



    group('test1', () {
      blocTest<PersonNameCubit, PersonNameState>(
        'canSave test',
        build: () => cubit,
        act: (cubit) => cubit.nickNameChanged("al"),
        wait: const Duration(milliseconds: 1000),
        expect: () => <dynamic>[
          isA<PersonNameState>()
              .having((s) => s.canSave, 'canSave', false),

        ],
      );

      blocTest<PersonNameCubit, PersonNameState>(
        'nickNameStatus.isValid test',
        build: () => cubit,
        act: (cubit) => cubit.nickNameChanged("alex"),
        wait: const Duration(milliseconds: 100),
        expect: () => <dynamic>[
          isA<PersonNameState>()
              .having((s) => s.nickNameStatus.isValid, 'nickNameStatus.isValid', true),
          isA<PersonNameState>()
              .having((s) => s.nickNameStatus.isValid, 'nickNameStatus.isValid', true),

        ],
     );

    });


  });
}
