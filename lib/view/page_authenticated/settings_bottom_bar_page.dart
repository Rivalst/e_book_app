import 'package:e_book_app/config/color_theme.dart';
import 'package:e_book_app/config/routes/routes.dart';
import 'package:e_book_app/controller/bloc/bottom_bar_bloc/bottom_bar_bloc.dart';
import 'package:e_book_app/view/utils_widgets/text_for_title_settings_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthenticatedPage extends StatelessWidget {
  const AuthenticatedPage({super.key});

  static Page<void> page() =>
      const MaterialPage<void>(child: AuthenticatedPage());

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomBarBloc, int>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(getTitle(index: state, context: context),
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: AppColorThemeBraunBlack.of(context).blackColor40)),
            backgroundColor:
                AppColorThemeBraunBlack.of(context).whiteColorBackground,
          ),
          body: onGenerateBottomBarItemPages(index: state),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            currentIndex: state,
            showUnselectedLabels: true,
            selectedItemColor:
                AppColorThemeBraunBlack.of(context).lightBraunColor100,
            unselectedItemColor:
                AppColorThemeBraunBlack.of(context).blackColor30,
            onTap: (index) => context
                .read<BottomBarBloc>()
                .add(BottomBarSetIndex(index: index)),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: const FaIcon(FontAwesomeIcons.house),
                  label: AppLocalizations.of(context)!.home),
              BottomNavigationBarItem(
                  icon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
                  label: AppLocalizations.of(context)!.discover),
              BottomNavigationBarItem(
                  icon: const FaIcon(FontAwesomeIcons.bookOpen),
                  label: AppLocalizations.of(context)!.library),
              BottomNavigationBarItem(
                  icon: const FaIcon(FontAwesomeIcons.user),
                  label: AppLocalizations.of(context)!.profile)
            ],
          ),
        );
      },
    );
  }
}
