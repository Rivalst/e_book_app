import 'package:authentication_repository/authentication_repository.dart';
import 'package:e_book_app/data/data_theme/color_theme.dart';
import 'package:e_book_app/routes/routes.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/app_bloc/app_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp(
      {required AuthenticationRepository authenticationRepository, super.key})
      : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) =>
            AppBloc(authenticationRepository: _authenticationRepository),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    final AppColorThemeBraunBlack theme = AppColorThemeBraunBlack();
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: theme.lightBraunColor100,
          selectionHandleColor: theme.lightBraunColor60
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: theme.blackColor60),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: theme.lightBraunColor100)
          ),
          filled: true,
          fillColor: Colors.white
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
