


import 'package:dog_api/dog_api.dart';
import 'package:flutter_myname_avatar/repository/store_repository.dart';
import 'package:nationalize_api/nationalize_api.dart';

import 'isar_db.dart';


class SaveLoadMock implements ISaveLoad {
  @override
  Future<void> save(String key, Map<String, dynamic> data) async
  {

  }

  @override
  Future<Map<String, dynamic>?> load(String key) async{
    return null;
  }
}

class Repository {

  late final DogApiClient dogApiClient ;
  late final NationalizeApiClient nationalizeApiClient;
  late final StoreRepository storeRepository;


  init() async {

    dogApiClient = DogApiClient();
    nationalizeApiClient = NationalizeApiClient();

    storeRepository = StoreRepository(db: ISarDB());
    await storeRepository.init();


  }


}
