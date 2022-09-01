

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_myname_avatar/repository/store_repository.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:synchronized/synchronized.dart';


part 'isar_db.g.dart';



final _lock = Lock();

///
///
///  In this sample just save all the history in one string serialized record for simplicity
///
@Collection()
class DBMessage {
  @Id()
  int? id;

  late String jsonMessage;
}

///
///
///
/// TODO: move this into external repo

class ISarDB implements ISaveLoad {


  @override
  Future<void> save(String key, Map<String, dynamic> data) async
  {
    await _lock.synchronized(() async {
      Isar? isar;
      try {
        final messageString = jsonEncode(data);

        final directory = await getApplicationSupportDirectory();
        isar = await Isar.open(

          directory: directory.path,
          schemas: [DBMessageSchema],
        );


        await isar.writeTxn((isar) async {
          await isar.dBMessages.delete(1);
        });


        final newDbMessage = DBMessage()
          ..id = 1
          ..jsonMessage = messageString;

        await isar.writeTxn((isar) async {
          newDbMessage.id = await isar.dBMessages.put(newDbMessage);
        });
      } catch (e) {
        debugPrint("$e");
        rethrow;
      } finally {
        isar?.close();
      }
    });
  }

  @override
  Future<Map<String, dynamic>?> load(String key) async {
    Map<String, dynamic>? result;

    await _lock.synchronized(() async {

      Isar? isar;

      try {


        final directory = await getApplicationSupportDirectory();

        isar = await Isar.open(
          directory: directory.path,

          schemas: [DBMessageSchema],
        );

        final allDbMessages = await isar.dBMessages.where().findAll();

        for (final dbMessage in allDbMessages) {
          debugPrint('dbMessage.id = ${dbMessage.id}');

          final map = (json.decode(dbMessage.jsonMessage) as Map<
              dynamic,
              dynamic>?)?.cast<String, dynamic>();


          result = map;
          break;
        }
      } catch (e, stack) {
        debugPrint("$e");
        rethrow;

      } finally {
        await isar?.close();
      }
    });
    return result;
  }
}
