

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myname_avatar/repository/store_repository.dart';
import 'package:flutter_myname_avatar/widgets/widgets.dart';
import 'package:nationalize_api/model.dart';


///
///
/// Shows simple small static scrollable history list

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key, required this.history}) : super(key: key);
  final List<StoreRepositoryEntry> history;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: ListView(
          children: history.reversed.map((e) => Padding(
            padding: const EdgeInsets.fromLTRB(20,10,20,10),
            child: SearchResultWidget(dogUrl: AsyncSnapshot<String>.withData(ConnectionState.done, e.dogUrl), nationalizeResponse: AsyncSnapshot<NationalizeResponse>.withData(ConnectionState.done, e.nationalizeResponse)),
          ))
              .toList(),
        ),
      ),

    );

  }
}
