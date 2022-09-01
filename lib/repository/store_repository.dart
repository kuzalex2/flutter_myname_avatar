
import 'package:equatable/equatable.dart';
import 'package:nationalize_api/model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreRepositoryEntry extends Equatable {
  final String dogUrl;
  final NationalizeResponse nationalizeResponse;

  const StoreRepositoryEntry({required this.dogUrl, required  this.nationalizeResponse});

  @override
  List<Object?> get props => [dogUrl, nationalizeResponse];

}

class StoreRepository {


  // static const int maxHistory = 2;
  static const int maxHistory = 10;


  late final SharedPreferences _prefs;

  BehaviorSubject<List<StoreRepositoryEntry>>? __stateController;
  BehaviorSubject<List<StoreRepositoryEntry>> get _stateController {
    return __stateController ??= BehaviorSubject<List<StoreRepositoryEntry>>();
  }

  List<StoreRepositoryEntry> _dataList = [];
  Stream<List<StoreRepositoryEntry>> get stream =>  _stateController.stream;


  init() async {
    _prefs = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 1));
    // _dataList = [
    //   const StoreRepositoryEntry(dogUrl: "", nationalizeResponse: NationalizeResponse(name: 'name', countries: [CountryProbability(countryCode: 'ru', probability: .9)]))
    // ];

    _stateController.add(_dataList);

  }


  saveEntry(StoreRepositoryEntry entry) async {
    await Future.delayed(const Duration(seconds: 1));


    _dataList.add(entry);
    while(_dataList.length > maxHistory){
      _dataList.removeAt(0);
    }
    _stateController.add(_dataList);
  }






}
