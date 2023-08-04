import 'package:e_book_app/config/color_theme.dart';
import 'package:e_book_app/view/page_unauthenticated//login_in_page.dart';
import 'package:e_book_app/view/page_unauthenticated//sing_up_page.dart';
import 'package:flutter/material.dart';

/// This is a page for [unauthenticated] users where they can log in or sing up
class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  static Page<void> page() =>
      const MaterialPage<void>(child: OnBoardingPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // const Placeholder(),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  )),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(20.0, 30.0, 0, 0),
                    child: Row(
                      children: [
                        const Text(
                          'Welcome to eBookApp',
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Icon(Icons.back_hand, color: Colors.amberAccent[400])
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0),
                    child: const Text(
                      'Explore the world of books: Discover your next favorite read in our e-book reading app.',
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.fromLTRB(20.0, 40, 20.0, 0),
                    child: FloatingActionButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SingUpPage())),
                      backgroundColor: AppColorThemeBraunBlack.of(context)
                          .lightBraunColor100,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        'Sing Up',
                        style: TextStyle(
                            color: AppColorThemeBraunBlack.of(context)
                                .lightBraunColor10,
                            fontWeight: FontWeight.bold,
                            fontSize: 19.0),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 30.0),
                    child: FloatingActionButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage())),
                      backgroundColor:
                          AppColorThemeBraunBlack.of(context).lightBraunColor10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                              color: AppColorThemeBraunBlack.of(context)
                                  .lightBraunColor100)),
                      child: Text(
                        'Log In',
                        style: TextStyle(
                            color: AppColorThemeBraunBlack.of(context)
                                .lightBraunColor100,
                            fontWeight: FontWeight.bold,
                            fontSize: 19.0),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      backgroundColor: AppColorThemeBraunBlack.of(context).whiteColorBackground,
    );
  }
}
