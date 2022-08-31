


import 'package:dog_api/dog_api.dart';
import 'package:nationalize_api/nationalize_api.dart';

class Repository {

  late final DogApiClient dogApiClient ;
  late final NationalizeApiClient nationalizeApiClient;


  init() async {

    dogApiClient = DogApiClient();
    nationalizeApiClient = NationalizeApiClient();


  }


}
