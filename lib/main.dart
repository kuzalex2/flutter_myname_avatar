
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
      body: ListView(
        children: [

          _InputField(),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: _SearchResults(),
          ),
          const SizedBox(height:20,),
          // Spacer(),
        ],
      ),
    );
  }
}


class _InputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonNameCubit, PersonNameState>(


      builder: (context, state) {




        String? errorText;

        if (state.checkStatus.isLocalInvalid ){
          if (state.nickName.value.length < NickName.minLength){
          } else {
            errorText = "ошибка";
          }
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

          NationalityWidget(nationalizeResponse: nationalizeResponse),

          const SizedBox(width: 10,),

        ],
      ),
    );
  }
}


