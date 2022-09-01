

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_myname_avatar/repository/repository.dart';
import 'package:flutter_myname_avatar/widgets/widgets.dart';
import 'bloc/person_name_cubit/person_name_cubit.dart';
import 'history_screen.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
          providers: [
            BlocProvider<PersonNameCubit>(
              create: (BuildContext context) =>
                  PersonNameCubit(context.read<Repository>(),nickName: ''),
            ),
          ],
          child: const _SearchScreen(),
      ),
    );
  }
}

class _SearchScreen extends StatelessWidget {
  const _SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Type your name please"),
      ),
      floatingActionButton: const _HistoryButton(),
      body: ListView(
        children: [

          _InputField(),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: _SearchResults(),
          ),
          const SizedBox(height:20,),

          const _SaveButton(),

          const SizedBox(height:20,),

        ],
      ),
    );
  }
}


class _HistoryButton extends StatelessWidget {
  const _HistoryButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonNameCubit, PersonNameState>(

        builder: (context, state) {

          final hasHistory = state.history.isNotEmpty;

          return CupertinoButton(
            padding: const EdgeInsets.only(top: 0, right: 20),
            minSize: 0,
            onPressed: hasHistory ? () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    HistoryScreen(history: state.history),
              ));
            } : null,
            child: const Text("History"),
          );

        }
    );
  }
}


class _InputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonNameCubit, PersonNameState>(


      builder: (context, state) {
        String? errorText;

        if (state.nickNameStatus.isInvalid ){
          errorText = "ошибка";
        } else if (state.isServerError){
          errorText = "ошибка";
        }


        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
          child: AppInputField(
            initialValue: state.nickName.value,

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

          if (state.nickNameStatus.isEmpty || state.nationalizeResponse.hasError) {
            return const SizedBox.shrink();
          }

          return SearchResultWidget(nationalizeResponse: state.nationalizeResponse, dogUrl: state.dogUrl,);
        }
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonNameCubit, PersonNameState>(

        builder: (context, state) {

          return Visibility(
            visible: state.hasResultForSave,
            child: CupertinoButton(
              padding: const EdgeInsets.only(top: 0, right: 20),
              minSize: 0,
              onPressed: state.canSave ? () { context.read<PersonNameCubit>().save();  } : null,
              child: state.saveStatus.isSaving ? const Padding(
                padding: EdgeInsets.only(right: 30.0),
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.blueAccent),
                  ),
                ),
              )

                  : const Text("Save"),
            ),
          );

        }
    );
  }
}





