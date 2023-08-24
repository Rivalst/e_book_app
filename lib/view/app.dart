import 'package:authentication_repository/authentication_repository.dart';
import 'package:e_book_app/config/color_theme.dart';
import 'package:e_book_app/config/routes/routes.dart';
import 'package:e_book_app/controller/bloc/book_get_bloc/book_get_bloc.dart';
import 'package:e_book_app/controller/bloc/bottom_bar_bloc/bottom_bar_bloc.dart';
import 'package:e_book_app/controller/cubit/count_of_loaded_book/count_of_book_cubit.dart';
import 'package:e_book_app/controller/cubit/language/language_cubit.dart';
import 'package:e_book_app/model/dataresources/remote/book_data.dart';
import 'package:e_book_app/view/utils_widgets/color_pallet_widget.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../controller/bloc/app_bloc/app_bloc.dart';

/// It's widget sets up the application's state management using
/// [RepositoryProvider] and [BlocProvider]. The [AuthenticationRepository] is
/// provided to the entire widget tree via [RepositoryProvider.value]
class MyApp extends StatelessWidget {
  const MyApp(
      {required AuthenticationRepository authenticationRepository, super.key})
      : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) =>
                AppBloc(authenticationRepository: _authenticationRepository),
          ),
          BlocProvider(
            create: (context) => BottomBarBloc(),
          ),
          BlocProvider(
            create: (context) => LanguageCubit(),
          ),
          BlocProvider(
              create: (context) => BookGetBloc(BooksRepository.instance)
          ),
          BlocProvider(
              create: (context) => CountOfBookCubit()
          )
        ],
        child: ColorPaletteInherited(
            palette: AppColorThemeBraunBlack(), child: const AppView()),
      ),
    );
  }
}

/// This widget for settings [ThemeData] and also show page depending user is
/// [authenticated] or [unauthenticated]
///
/// This logic for page controlled FlowBuilder with [onGenerateAppViewPages] routes
class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        return MaterialApp(
          locale: Locale(state.selectedLanguage == Language.ukrainian ? 'uk' : 'en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
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
              onGeneratePages: onGenerateAppViewPages),
        );
      },
    );
  }
}
