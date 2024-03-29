import 'package:authentication_repository/authentication_repository.dart';
import 'package:e_book_app/config/color_theme.dart';
import 'package:e_book_app/config/routes/routes.dart';
import 'package:e_book_app/controller/bloc/book_get_bloc/book_get_bloc.dart';
import 'package:e_book_app/controller/bloc/book_library_get/book_library_get_bloc.dart';
import 'package:e_book_app/controller/bloc/bottom_bar_bloc/bottom_bar_bloc.dart';
import 'package:e_book_app/controller/cubit/book_discover/book_discover_cubit.dart';
import 'package:e_book_app/controller/cubit/book_discover_library/book_discover_library_cubit.dart';
import 'package:e_book_app/controller/cubit/filter_for_books/filter_mark_cubit.dart';
import 'package:e_book_app/controller/cubit/loaded_book/count_of_book_cubit.dart';
import 'package:e_book_app/controller/cubit/language/language_cubit.dart';
import 'package:e_book_app/controller/cubit/loaded_book/is_load_cubit.dart';
import 'package:e_book_app/model/repositories/book_repository.dart';
import 'package:e_book_app/view/utils_widgets/color_pallet_widget.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../controller/bloc/app_bloc/app_bloc.dart';

/// It's widget sets up the application's state management using
/// [RepositoryProvider] and [BlocProvider]. The [AuthenticationRepository] is
/// provided to the entire widget tree via [RepositoryProvider.value]
/// This widget also for settings [ThemeData]

class MyApp extends StatelessWidget {
  const MyApp(
      {required AuthenticationRepository authenticationRepository, super.key})
      : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  Future<void> _loadLibrary() async {
    final booksRepo = BooksRepository.instance;
    await booksRepo.fetchBooksData();
    await booksRepo.fetchBookLibraryData();
  }

  @override
  Widget build(BuildContext context) {
    return ColorPaletteInherited(
      palette: AppColorThemeBraunBlack(),
      child: BlocProvider(
        create: (context) => LanguageCubit(),
        child: BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, state) {
            return MaterialApp(
              locale: Locale(
                  state.selectedLanguage == Language.ukrainian ? 'uk' : 'en'),
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
                        color:
                            AppColorThemeBraunBlack.of(context).blackColor60),
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
              home: FutureBuilder(
                  future: _loadLibrary(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        color: AppColorThemeBraunBlack.of(context)
                            .whiteColorBackground,
                        child: Center(
                          child: LinearProgressIndicator(
                            backgroundColor: AppColorThemeBraunBlack.of(context)
                                .whiteColorBackground,
                            color: AppColorThemeBraunBlack.of(context)
                                .lightBraunColor100,
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      return RepositoryProvider.value(
                        value: _authenticationRepository,
                        child: MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (_) => AppBloc(
                                  authenticationRepository:
                                      _authenticationRepository),
                            ),
                            BlocProvider(
                              create: (context) => BottomBarBloc(),
                            ),
                            BlocProvider(
                                create: (context) => BookGetBloc(
                                    BooksRepository.instance.books)),
                            BlocProvider(
                                create: (context) => CountOfBookCubit()),
                            BlocProvider(create: (context) => IsLoadCubit()),
                            BlocProvider(
                                create: (context) => BookDiscoverCubit(
                                    books: BooksRepository.instance.books)),
                            BlocProvider(
                                create: (context) => FilterMarkCubit()),
                            BlocProvider(
                                create: (context) =>
                                    BookDiscoverLibraryCubit()),
                            BlocProvider(
                                create: (context) => BookLibraryGetBloc(
                                    booksList: BooksRepository.instance.books,
                                    booksMap: BooksRepository
                                        .instance.booksInLibraryMap))
                          ],
                          child: const AppView(),
                        ),
                      );
                    }
                  }),
            );
          },
        ),
      ),
    );
  }
}

/// This logic for page controlled FlowBuilder with [onGenerateAppViewPages] routes
/// show page depending user is [authenticated] or [unauthenticated]
class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages);
  }
}
