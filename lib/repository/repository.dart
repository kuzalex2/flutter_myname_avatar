


import 'package:dog_api/dog_api.dart';
import 'package:flutter_myname_avatar/repository/store_repository.dart';
import 'package:nationalize_api/nationalize_api.dart';

class Repository {

  late final DogApiClient dogApiClient ;
  late final NationalizeApiClient nationalizeApiClient;
  late final StoreRepository storeRepository;


  init() async {

    dogApiClient = DogApiClient();
    nationalizeApiClient = NationalizeApiClient();

    storeRepository = StoreRepository();
    await storeRepository.init();


  }


}
