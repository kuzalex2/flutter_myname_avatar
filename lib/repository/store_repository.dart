
import 'package:flutter/cupertino.dart';
import 'package:flutter_myname_avatar/repository/store_reposotory_model.dart';
import 'package:rxdart/rxdart.dart';


abstract class ISaveLoad {
  Future<void> save(String key, Map<String, dynamic> data) ;

  Future<Map<String, dynamic>?> load(String key);
}

class StoreRepository {


  // static const int maxHistory = 2;
  static const int maxHistory = 10;

  final ISaveLoad db;
  List<StoreRepositoryEntry> _dataList = [];


  StoreRepository({required this.db})
  ;





  BehaviorSubject<List<StoreRepositoryEntry>>? __stateController;
  BehaviorSubject<List<StoreRepositoryEntry>> get _stateController {
    return __stateController ??= BehaviorSubject<List<StoreRepositoryEntry>>();
  }
  Stream<List<StoreRepositoryEntry>> get stream =>  _stateController.stream;



  init() async {
    await Future.delayed(const Duration(seconds: 1));

    try {
      final saved = await db.load("history");
      if (saved!=null) {
        final parsed = StoreRepositoryList.fromJson(saved);
        _dataList = parsed.list;
      }
    } catch (e) {
      debugPrint('$e');
    }


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

    try {
      await db.save("history", StoreRepositoryList(list: _dataList).toJson());
    } catch (e) {
      debugPrint('$e');
      rethrow;
    }
  }






}
