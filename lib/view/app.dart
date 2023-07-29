import 'package:authentication_repository/authentication_repository.dart';
import 'package:e_book_app/view/utilit_widgets/color_theme.dart';
import 'package:e_book_app/routes/routes.dart';
import 'package:e_book_app/view/utilit_widgets/color_pallet_widget.dart';
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
    return ColorPaletteInherited(
      palette: AppColorThemeBraunBlack(),
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          textSelectionTheme: TextSelectionThemeData(
              cursorColor:
                  AppColorThemeBraunBlack.of(context).lightBraunColor100,
              selectionHandleColor:
                  AppColorThemeBraunBlack.of(context).lightBraunColor60),
          inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(
                  color: AppColorThemeBraunBlack.of(context).blackColor60),
              enabledBorder: UnderlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColorThemeBraunBlack.of(context)
                          .lightBraunColor100)),
              filled: true,
              fillColor: Colors.white),
        ),
        debugShowCheckedModeBanner: false,
        home: FlowBuilder<AppStatus>(
          state: context.select((AppBloc bloc) => bloc.state.status),
          onGeneratePages: onGenerateAppViewPages,
        ),
      ),
    );
  }
}
