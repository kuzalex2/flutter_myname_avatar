


part of 'person_name_cubit.dart';



///
///
/// Name validator - only r'^[a-zA-Z0-9_]{3,}$' is valid
///

enum NickNameValidationError { invalid }

class NickName extends FormzInput<String, NickNameValidationError> {
  const NickName.pure([String value = '']) : super.pure(value);
  const NickName.dirty([String value = '']) : super.dirty(value);

  static const int minLength = 3;
  static final RegExp _regExp = RegExp(r'^[a-zA-Z0-9_]{3,}$');

  @override
  NickNameValidationError? validator(String? value) {
    return _regExp.hasMatch(value ?? '')
        ? null
        : NickNameValidationError.invalid;
  }
}



enum NickNameStatus {
  empty,
  valid,
  invalid,
}
extension NickNameStatusX on NickNameStatus {

  bool get isEmpty => this == NickNameStatus.empty;

  bool get isValid => this == NickNameStatus.valid;

  bool get isInvalid => this == NickNameStatus.invalid;
}


enum SaveStatus {
  no,
  saving,
  error,
  saved
}

extension SaveStatusX on SaveStatus {

  bool get isSaving => this == SaveStatus.saving;
  bool get isSaved => this == SaveStatus.saved;

}

class PersonNameState extends Equatable {


  ///
  final NickName nickName;

  /// checking status of Dog picture /wait/error/done
  final AsyncSnapshot<String> dogUrl;

  /// checking status of Nationality /wait/error/done
  final AsyncSnapshot<NationalizeResponse> nationalizeResponse;


  NickNameStatus get nickNameStatus {

    if (nickName.value.length < NickName.minLength){
      return NickNameStatus.empty;
    }

    return nickName.valid ? NickNameStatus.valid : NickNameStatus.invalid;
  }

  bool get isServerError {
    return dogUrl.hasError || nationalizeResponse.hasError;
  }

  bool get hasResultForSave =>
    !dogUrl.hasError && dogUrl.hasData && !nationalizeResponse.hasError && nationalizeResponse.hasData && nickNameStatus.isValid;

  bool get canSave =>
      hasResultForSave && !saveStatus.isSaving && !saveStatus.isSaved && nickNameStatus.isValid;


  ///
  ///

  final SaveStatus saveStatus;

  ///
  ///
  final String saveError;

  ///
  ///
  final int saveId;


  ///
  ///
  ///

  final List<StoreRepositoryEntry> history;

  const PersonNameState._({
    required this.nickName,
    required this.dogUrl,
    required this.nationalizeResponse,
    required this.saveStatus,
    required this.saveError,
    required this.saveId,
    required this.history,
  });

  factory PersonNameState(
      String? nickName,
      ){
    final _nickName = NickName.dirty(nickName ?? '');

    return PersonNameState._(
      nickName: _nickName,
      dogUrl: const AsyncSnapshot<String>.nothing(),
      nationalizeResponse: const AsyncSnapshot<NationalizeResponse>.nothing(),
      saveStatus: SaveStatus.no,
      saveError: "",
      saveId: 0,
      history: const [],
    );
  }



  @override
  List<Object> get props => [
    nickName,
    dogUrl,
    nationalizeResponse,
    saveStatus,
    saveError,
    saveId,
    history,
  ];

  PersonNameState copyWith({
    NickName? nickName,
    SaveStatus? saveStatus,
    String? saveError,
    AsyncSnapshot<String>? dogUrl,
    AsyncSnapshot<NationalizeResponse>? nationalizeResponse,
    int? saveId,
    List<StoreRepositoryEntry>? history,



  }) {
    return PersonNameState._(
      nickName: nickName ?? this.nickName,
      saveStatus: saveStatus ?? this.saveStatus,
      saveError: saveError ?? this.saveError,
      dogUrl: dogUrl ?? this.dogUrl,
      nationalizeResponse: nationalizeResponse ?? this.nationalizeResponse,
      saveId: saveId ?? this.saveId,
      history: history ?? this.history,
    );
  }



}