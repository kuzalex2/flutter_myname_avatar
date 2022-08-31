


part of 'person_name_cubit.dart';



enum NickNameStatus {
  localValid,
  localInvalid,
  serverChecking,
  serverValid,
  serverError,
}

extension NickNameStatusX on NickNameStatus {

  bool get isServerValid => this == NickNameStatus.serverValid;

  bool get isServerError => this == NickNameStatus.serverError;

  bool get isServerChecking => this == NickNameStatus.serverChecking;

  bool get isLocalInvalid => this == NickNameStatus.localInvalid ;

  bool get isLocalValid => this == NickNameStatus.localValid;

}



enum NickNameValidationError { invalid }

class NickName extends FormzInput<String, NickNameValidationError> {
  const NickName.pure([String value = '']) : super.pure(value);
  const NickName.dirty([String value = '']) : super.dirty(value);

  static final RegExp _regExp =RegExp(r'^[a-zA-Z0-9_]{3,}$');

  @override
  NickNameValidationError? validator(String? value) {
    return _regExp.hasMatch(value ?? '')
        ? null
        : NickNameValidationError.invalid;
  }
}


class AppException implements Exception {

  final String message;


  /// AppException
  const AppException(String? message) :
        message = message ?? ''
  ;

  /// success - no error
  const AppException.success()
      :
        message = ''
  ;
}


class PersonNameState extends Equatable {


  ///
  final NickName nickName;

  /// стаатус проверки nickName
  final NickNameStatus checkStatus;

  ///
  final AsyncSnapshot<String> dogUrl;

  ///
  final AsyncSnapshot<NationalizeResponse> nationalizeResponse;

  /// статус сохранения nickName
  // final FormzStatus saveStatus;

  ///
  // final AppException saveError;
  ///
  // final AppException checkError;





  const PersonNameState._({
    required this.nickName,
    required this.checkStatus,
    required this.dogUrl,
    required this.nationalizeResponse,
    // required this.saveStatus,
    // required this.saveError,
    // required this.checkError,
  });

  factory PersonNameState(
      String? nickName,
      ){
    final _nickName = NickName.dirty(nickName ?? '');
    return PersonNameState._(
      nickName: _nickName,
      checkStatus: _nickName.valid ? NickNameStatus.localValid : NickNameStatus.localInvalid,
      dogUrl: const AsyncSnapshot<String>.nothing(),
      nationalizeResponse: const AsyncSnapshot<NationalizeResponse>.nothing(),
      // saveStatus: FormzStatus.pure,
      // saveError: const AppException.success(),
      // checkError: const AppException.success(),
    );
  }



  @override
  List<Object> get props => [nickName, checkStatus, dogUrl, nationalizeResponse,/* saveStatus, saveError*/];

  PersonNameState copyWith({
    NickName? nickName,
    NickNameStatus? checkStatus,
    // FormzStatus? saveStatus,
    // AppException? saveError,
    // AppException? checkError,
    AsyncSnapshot<String>? dogUrl,
    AsyncSnapshot<NationalizeResponse>? nationalizeResponse,

  }) {
    return PersonNameState._(
      nickName: nickName ?? this.nickName,
      checkStatus: checkStatus ?? this.checkStatus,
      // saveStatus: saveStatus ?? this.saveStatus,
      // saveError: saveError ?? this.saveError,
      dogUrl: dogUrl ?? this.dogUrl,
      nationalizeResponse: nationalizeResponse ?? this.nationalizeResponse,
    );
  }



}