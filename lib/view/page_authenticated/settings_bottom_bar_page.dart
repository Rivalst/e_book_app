import 'package:e_book_app/config/color_theme.dart';
import 'package:e_book_app/config/routes/routes.dart';
import 'package:e_book_app/controller/bloc/app_bloc/app_bloc.dart';
import 'package:e_book_app/controller/bloc/bottom_bar_bloc/bottom_bar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
            title: const Text('Home'),
            actions: <Widget>[
              IconButton(
                key: const Key('authenticatedPage_logout_iconButton'),
                icon: const Icon(Icons.exit_to_app),
                onPressed: () {
                  context.read<AppBloc>().add(const AppLogOutRequested());
                },
              )
            ],
          ),
          body: onGenerateBottomBarItemPages(index: state),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor:
                AppColorThemeBraunBlack.of(context).whiteColorBackground,
            currentIndex: state,
            showUnselectedLabels: true,
            selectedItemColor: AppColorThemeBraunBlack.of(context).lightBraunColor100,
            unselectedItemColor: AppColorThemeBraunBlack.of(context).blackColor30,
            onTap: (index) => context
                .read<BottomBarBloc>()
                .add(BottomBarSetIndex(index: index)),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.house),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
                  label: 'Discover'),
              BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.bookOpen),
                  label: 'Library'),
              BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.user),
                  label: 'Profile')
            ],
          ),
        );
      },
    );
  }
}
