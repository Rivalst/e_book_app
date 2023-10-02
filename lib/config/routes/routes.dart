import 'package:e_book_app/model/repositories/book_repository.dart';
import 'package:e_book_app/view/page_authenticated/discover_page.dart';
import 'package:e_book_app/view/page_authenticated/home_page.dart';
import 'package:e_book_app/view/page_authenticated/library_page.dart';
import 'package:e_book_app/view/page_authenticated/settings_bottom_bar_page.dart';
import 'package:e_book_app/view/page_authenticated/profile_page.dart';
import 'package:e_book_app/view/page_unauthenticated//on_boarding_page.dart';
import 'package:flutter/material.dart';

import '../../controller/bloc/app_bloc/app_bloc.dart';

/// This is a rout for [authenticated] or [unauthenticated] users.
List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [AuthenticatedPage.page()];
    case AppStatus.unauthenticated:
      return [OnBoardingPage.page()];
    default:
      return [OnBoardingPage.page()];
  }
}

Widget onGenerateBottomBarItemPages({required int index}) {
  switch (index) {
    case 0:
      return const HomePage();
    case 1:
      return const DiscoverPage();
    case 2:
      return const LibraryPage();
    case 3:
      return const UserPage();
    default:
      return const HomePage();
  }
}
