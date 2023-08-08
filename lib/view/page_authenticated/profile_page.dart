import 'package:e_book_app/config/color_theme.dart';
import 'package:e_book_app/controller/bloc/app_bloc/app_bloc.dart';
import 'package:e_book_app/controller/cubit/language/language_cubit.dart';
import 'package:e_book_app/view/page_authenticated/page_for_profile/language_settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 20),

          /// Display User Photo, name and email
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1), // Shadow color
                      spreadRadius: 3, // Spread radius
                      blurRadius: 3, // Blur radius// Offset in the y-direction
                    ),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 35.0,
                    backgroundImage:
                        Image.asset('assets/user_profile_photo.png').image,
                    backgroundColor: AppColorThemeBraunBlack.of(context)
                        .whiteColorBackground,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name!,
                          style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              color: AppColorThemeBraunBlack.of(context)
                                  .blackColor80)),
                      const SizedBox(height: 5.0),
                      Text(
                        user.email!,
                        style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w400,
                            color: AppColorThemeBraunBlack.of(context)
                                .blackColor30),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),

          /// Language
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 0),
            child: Text(AppLocalizations.of(context)!.language,
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: AppColorThemeBraunBlack.of(context).blackColor30)),
          ),

          /// Set Language
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 20.0),
            child: GestureDetector(
              onTap: () {
                showLanguageAlertDialog(context: context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        // Shadow color
                        spreadRadius: 3,
                        // Spread radius
                        blurRadius:
                            3, // Blur radius// Offset in the y-direction
                      ),
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Language',
                        style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500,
                            color: AppColorThemeBraunBlack.of(context)
                                .blackColor80)),
                    Icon(
                      Icons.keyboard_arrow_right_outlined,
                      color: AppColorThemeBraunBlack.of(context).blackColor30,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      backgroundColor: AppColorThemeBraunBlack.of(context).whiteColorBackground,
    );
  }
}

