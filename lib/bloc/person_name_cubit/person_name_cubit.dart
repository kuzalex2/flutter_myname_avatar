
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_myname_avatar/repository/store_repository.dart';
import 'package:formz/formz.dart';
import 'package:nationalize_api/model.dart';

import '../../repository/repository.dart';
import '../../repository/store_reposotory_model.dart';

part 'person_name_state.dart';







class PersonNameCubit extends Cubit<PersonNameState> {


  PersonNameCubit(this.repository, {required String nickName}) :
        super(PersonNameState(nickName),)
  {
    repository.storeRepository.stream.listen((history) {
      emit(state.copyWith(history: List.of(history)));
    });
    if (state.nickNameStatus.isValid){
      emit(state.copyWith(dogUrl: const AsyncSnapshot<String>.waiting(), nationalizeResponse: const AsyncSnapshot<NationalizeResponse>.waiting() ));

      _serverCheck(nickName);
    }
  }


  final Repository repository;



  void nickNameChanged(String value) {

    emit(state.copyWith(nickName: NickName.dirty(value)));




    if (!state.nickNameStatus.isValid){
      return;
    }


    emit(state.copyWith(dogUrl: const AsyncSnapshot<String>.waiting(), nationalizeResponse: const AsyncSnapshot<NationalizeResponse>.waiting(), saveStatus: SaveStatus.no, saveError: "", saveId: state.saveId + 1 ));


    Future.delayed(const Duration(seconds: 1)).then((_) {

      if (value == state.nickName.value){
        _serverCheck(value);
      }
    } );
  }


  ///
  ///
  ///

  _serverCheck(String nickName) async {

    debugPrint("Checking $nickName");

    try {

      ///
      ///
      ///
      final predicted = await repository.nationalizeApiClient.predict(nickName);

      if (nickName == state.nickName.value){

        emit(state.copyWith( nationalizeResponse: AsyncSnapshot<NationalizeResponse>.withData(ConnectionState.done, predicted) ));


        try {

          final dogUrl = await repository.dogApiClient.breed('hound');

          if (nickName == state.nickName.value){

            if (dogUrl.isEmpty){
              emit(state.copyWith( dogUrl: const AsyncSnapshot<String>.withError(ConnectionState.done, "no images") ));
              return;

            } else {

              emit(state.copyWith( dogUrl: AsyncSnapshot<String>.withData(ConnectionState.done, dogUrl[Random().nextInt(dogUrl.length) ]) ));
              return;


            }

          } else {
            debugPrint("Changed");
          }

        } catch (e){
          if (nickName == state.nickName.value){
            emit(state.copyWith(  dogUrl: AsyncSnapshot<String>.withError(ConnectionState.done, e) ));

          } else {
            debugPrint("Changed");
          }
        }


      } else {
        debugPrint("Changed");
      }

    } catch (e){
      if (nickName == state.nickName.value){
        emit(state.copyWith( nationalizeResponse: AsyncSnapshot<NationalizeResponse>.withError(ConnectionState.done, e) ));

      } else {
        debugPrint("Changed");
      }
    }
  }


  Future<void> save() async {

    if (!state.canSave){
      return;
    }

    final saveId = state.saveId;

    emit(state.copyWith( saveStatus: SaveStatus.saving, saveError: ""));

    try {
      await repository.storeRepository.saveEntry(StoreRepositoryEntry(dogUrl: state.dogUrl.data!, nationalizeResponse: state.nationalizeResponse.data!));
      // throw "aaa"
    } catch (e){
      if (saveId == state.saveId){
        emit(state.copyWith( saveStatus: SaveStatus.error, saveError: '$e'));
      }
      return;
    }


    if (saveId == state.saveId) {
      emit(state.copyWith(saveStatus: SaveStatus.saved));
    }
  }

}

