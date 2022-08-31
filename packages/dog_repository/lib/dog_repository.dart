library dog_repository;

// class WeatherFailure implements Exception {}

import 'dart:math';

import 'package:dog_api/dog_api.dart';
import 'package:flutter/cupertino.dart';

class DogRepository {
  DogRepository({DogApiClient? dogApiClient})
      : _dogApiClient = dogApiClient ?? DogApiClient();

  final DogApiClient _dogApiClient;

  Future<String> dogPictureUrl() async {
    await Future.delayed(const Duration(seconds: 1));
    // throw  DogRequestNot200Failure();
    try {
      final list = await _dogApiClient.breed("hound");
      if (list.isEmpty){
        return "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHJIC2SjOVQUe1YpJlbGADeRTYE_49D3KFOHi6wTC6yQPHLIZuzO87D7Vpwxg1IB_tRtU&usqp=CAU";
      }
      return list[ Random().nextInt(list.length) ];

    } catch (e) {
      debugPrint("dogPictureUrl failed: $e");
      rethrow;
    }

  }

}


