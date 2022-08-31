
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_myname_avatar/repository.dart';
import 'package:flutter_myname_avatar/widgets/widgets.dart';
import 'package:nationalize_api/model.dart';
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
        child: const MyApp()
    );
  }
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<PersonNameCubit>(
            create: (BuildContext context) =>
                PersonNameCubit(context.read<Repository>(),nickName: ''),
          ),
        ],
        child: const MaterialApp(
          home: SearchScreen(),
        )
    );
  }
}


class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Type your name please"),
      ),
      body: Center(
        child: Column(children: [
          _InputField(),
          const _SearchResults(),
        ],),
      ),
    );
  }
}


class _InputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonNameCubit, PersonNameState>(


      // buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {




        String? errorText;

        if (state.checkStatus.isLocalInvalid && state.nickName.value.isNotEmpty){
          errorText = null;
        } else if (state.checkStatus.isServerValid){
          // errorText = "адрес свободен";
        } else if (state.checkStatus.isServerError){
          errorText = "ошибка";
        }


        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
          child: AppInputField(
            // key: const Key('loginForm_emailInput_textField'),
            initialValue: state.nickName.value,
            // style: theme.fonts.bodyBold.copyWith(color: theme.colors.black),
            // prefixIcon: Padding(
            //   padding: const EdgeInsets.only(bottom: 5.0),
            //   child: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       Icon(UniconsLine.user_circle, color: theme.colors.black),
            //       SizedBox(width: 8,),
            //       Text(S.of(context).Exprts_PRO, style: theme.fonts.bodyNormal.copyWith(color: theme.colors.black50o),),
            //     ],
            //   ),
            // ),




            // suffixIcon: state.checkStatus.isServerChecking ? const Loader() : null,
            onChanged: (value) => context.read<PersonNameCubit>().nickNameChanged(value),
            autofocus: true,
            // readOnly: state.saveStatus.isSubmissionInProgress || state.saveStatus.isSubmissionSuccess,
            errorText: errorText,
          ),
        );
      },
    );
  }
}


class _SearchResults extends StatelessWidget {
  const _SearchResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonNameCubit, PersonNameState>(

        builder: (context, state) {
          if (state.checkStatus.isLocalInvalid || state.nationalizeResponse.hasError) {
            return const SizedBox.shrink();
          }

          return SearchResultWidget(nationalizeResponse: state.nationalizeResponse, dogUrl: state.dogUrl,);
      }
    );
  }
}


class SearchResultWidget extends StatelessWidget {
  ///
  final AsyncSnapshot<String> dogUrl;

  ///
  final AsyncSnapshot<NationalizeResponse> nationalizeResponse;


  const SearchResultWidget({Key? key, required this.dogUrl, required this.nationalizeResponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16),),

        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12.0,
            spreadRadius: 0.0,
            offset: Offset(0.0, 2.0), // shadow direction: bottom right
          )
        ],
      ),
      child:Row(
        children: [
          const SizedBox(width: 10,),

          DogImageWidget(url: dogUrl, size: 150,),

          const SizedBox(width: 10,),

          () {
            if (nationalizeResponse.hasError) {
              return const Icon(Icons.error);
            }

            if (nationalizeResponse.data==null) {
              return const SizedBox.shrink();
            }

            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Text(nationalizeResponse.data!.name),
                  ...nationalizeResponse.data!.countries.map((e) => Text('${e.country} ${(e.probability*100).round()} %')).toList()
                ]);

          } (),

          const SizedBox(width: 10,),

        ],
      ),
    );
  }
}




// void main() {
//   runApp(MyApp());
// }
//
// class AAA {
//   AsyncSnapshot<NationalizeResponse>? a1;
//
//   aaa() {
//     a1 = const AsyncSnapshot<NationalizeResponse>.waiting();
//     a1 = const AsyncSnapshot<NationalizeResponse>.withError(ConnectionState.done, "someError");
//     a1 = const AsyncSnapshot<NationalizeResponse>.withData(ConnectionState.done, NationalizeResponse(name: '', countries: []));
//   }
// }
//
// class MyApp extends StatelessWidget {
//
//   MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   final DogApiClient dogApiClient = DogApiClient();
//   final NationalizeApiClient nationalizeApiClient = NationalizeApiClient();
//
//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//
//
//
//             Container(
//
//               padding: const EdgeInsets.only(top: 20, bottom: 20),
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.all(Radius.circular(16),),
//
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 12.0,
//                     spreadRadius: 0.0,
//                     offset: Offset(0.0, 2.0), // shadow direction: bottom right
//                   )
//                 ],
//               ),
//               child:Row(
//                 children: [
//                   const SizedBox(width: 10,),
//                   FutureBuilder<List<String>>(
//                       future: dogApiClient.breed('hound'),
//                       builder: (context, snapshot) {
//
//                         final AsyncSnapshot<String> url;
//                         if (snapshot.hasError) {
//                           url = AsyncSnapshot<String>.withError(
//                               ConnectionState.done, snapshot.error!);
//                         } else if (snapshot.data!=null){
//                           final list = snapshot.data!;
//
//                           if (list.isEmpty){
//                             url = const AsyncSnapshot<String>.withError(
//                                 ConnectionState.done, "empty result");
//                           } else {
//                             url = AsyncSnapshot<String>.withData(
//                                 ConnectionState.done,
//                                 list[Random().nextInt(list.length) ]);
//                           }
//                         } else {
//                           url = const AsyncSnapshot<String>.waiting();
//                         }
//
//
//                         return DogImageWidget(url: url, size: 150,);
//                       }
//                   ),
//
//                   const SizedBox(width: 10,),
//
//
//                   FutureBuilder<NationalizeResponse>(
//                       future: nationalizeApiClient.predict('alex'),
//                       builder: (context, snapshot) {
//                         if (snapshot.hasError) {
//                           return const Icon(Icons.error);
//                         }
//
//                         if (snapshot.data==null) {
//                           return const SizedBox.shrink();
//                         }
//
//                         return Column(children:
//                         // [],
//                         snapshot.data!.countries.map((e) => Text('${e.country} ${(e.probability*100).round()} %')).toList()
//                         );
//
//
//
//
//                       }
//                   ),
//
//                   const SizedBox(width: 10,),
//
//                 ],
//               ),
//             ),
//
//
//
//
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
