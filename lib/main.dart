
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_myname_avatar/repository/repository.dart';
import 'package:flutter_myname_avatar/search_screen.dart';
import 'bloc/person_name_cubit/person_name_cubit.dart';
import 'bloc_observer.dart';


const bool isProduction = bool.fromEnvironment('dart.vm.product');


Future<void> main() async {
  if (isProduction) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();

  final repository = Repository();
  await repository.init();


  runApp(App(repository: repository));
}

class App extends StatelessWidget {
  const App({Key? key, required this.repository}):super(key: key);

  final Repository repository;

  @override
  Widget build(BuildContext context) {

    return RepositoryProvider.value(
        value: repository,
        child: const SearchScreen(),
    );
  }
}

