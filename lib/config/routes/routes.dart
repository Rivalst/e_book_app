import 'package:e_book_app/view/page_home/page_home.dart';
import 'package:e_book_app/view/page_start/on_boarding_page.dart';
import 'package:flutter/material.dart';

import '../../controller/bloc/app_bloc/app_bloc.dart';


/// This is a rout for [authenticated] or [unauthenticated] users.
List<Page<dynamic>> onGenerateAppViewPages(
    AppStatus state,
    List<Page<dynamic>> pages,
    ) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [OnBoardingPage.page()];
  }
}