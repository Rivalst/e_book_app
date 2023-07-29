import 'package:e_book_app/view/utilit_widgets/color_theme.dart';
import 'package:e_book_app/view/page_start/page_login_in.dart';
import 'package:e_book_app/view/page_start/page_sing_up.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(child: OnBoardingPage());

  @override
  Widget build(BuildContext context) {
    final AppColorThemeBraunBlack theme = AppColorThemeBraunBlack();
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Placeholder(),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
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
                      backgroundColor: theme.lightBraunColor100,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        'Sing Up',
                        style: TextStyle(
                            color: theme.lightBraunColor10,
                            fontWeight: FontWeight.bold,
                            fontSize: 19.0),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0),
                    child: FloatingActionButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage())),
                      backgroundColor: theme.lightBraunColor10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: theme.lightBraunColor100)),
                      child: Text(
                        'Log In',
                        style: TextStyle(
                            color: theme.lightBraunColor100,
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
      backgroundColor: theme.whiteColorBackground,
    );
  }
}
