
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:nationalize_api/model.dart';

import '../../repository.dart';

part 'person_name_state.dart';







class PersonNameCubit extends Cubit<PersonNameState> {


  PersonNameCubit(this.repository, {required String nickName}) :
        super(
        PersonNameState(nickName),
      )
  {
    if (state.checkStatus.isLocalValid){
      emit(state.copyWith(checkStatus: NickNameStatus.serverChecking, ));

      _serverCheck(nickName);

    }
  }


  final Repository repository;


  // void resetSave(){
  //   emit(state.copyWith( saveStatus: FormzStatus.pure, saveError: const AppException.success(),));
  // }



  void nickNameChanged(String value) {

    final nickName = NickName.dirty(value);

    if (!nickName.valid){

      emit(state.copyWith(nickName: nickName, checkStatus: NickNameStatus.localInvalid));

      return;
    }


    emit(state.copyWith(nickName: nickName, checkStatus: NickNameStatus.serverChecking, dogUrl: const AsyncSnapshot<String>.waiting(), nationalizeResponse: const AsyncSnapshot<NationalizeResponse>.waiting() ));


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
              emit(state.copyWith( checkStatus: NickNameStatus.serverError, dogUrl: const AsyncSnapshot<String>.withError(ConnectionState.done, "no images") ));
              return;

            } else {

              emit(state.copyWith( checkStatus:  NickNameStatus.serverValid, dogUrl: AsyncSnapshot<String>.withData(ConnectionState.done, dogUrl[Random().nextInt(dogUrl.length) ]) ));
              return;


            }

          } else {
            debugPrint("Changed");
          }

        } catch (e){
          if (nickName == state.nickName.value){
            emit(state.copyWith( checkStatus: NickNameStatus.serverError, dogUrl: AsyncSnapshot<String>.withError(ConnectionState.done, e) ));

          } else {
            debugPrint("Changed");
          }
        }


      } else {
        debugPrint("Changed");
      }

    } catch (e){
      if (nickName == state.nickName.value){
        emit(state.copyWith( checkStatus: NickNameStatus.serverError, nationalizeResponse: AsyncSnapshot<NationalizeResponse>.withError(ConnectionState.done, e) ));

      } else {
        debugPrint("Changed");
      }
    }
  }


  // Future<void> saveNickName() async {
  //
  //   if (!state.checkStatus.isServerValid)
  //     return;
  //
  //   emit(state.copyWith( saveStatus: FormzStatus.submissionInProgress));
  //
  //   try {
  //     final result = await repository.expertsRepository.saveNickName(nickName: state.nickName.value, userId: userId);
  //
  //     emit(state.copyWith( saveStatus: FormzStatus.submissionSuccess ));
  //
  //
  //   } on ExpertsRepositoryFailure catch(e) {
  //     emit(state.copyWith( saveStatus: FormzStatus.submissionFailure, saveError:  e ));
  //
  //   } catch (e){
  //     emit(state.copyWith( saveStatus: FormzStatus.submissionFailure, saveError:  AppException.unknown(e) ));
  //
  //   }
  //
  // }

}

