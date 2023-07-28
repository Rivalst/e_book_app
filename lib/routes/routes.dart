import 'package:e_book_app/view/page_home/page_home.dart';
import 'package:e_book_app/view/page_start/page_onboarding.dart';
import 'package:flutter/material.dart';

import '../bloc/app_bloc/app_bloc.dart';

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