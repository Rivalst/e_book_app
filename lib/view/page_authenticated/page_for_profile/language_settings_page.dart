import 'package:e_book_app/config/color_theme.dart';
import 'package:e_book_app/controller/cubit/language/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: const Text('Select Language'),
//     ),
//     body: ListView(
//       children: [
//         ListTile(
//           title: const Text('English'),
//           onTap: () {
//             context.read<LanguageCubit>().changeLanguage(Language.english);
//             Navigator.pop(context); // Повертаємося на попередній екран
//           },
//         ),
//         ListTile(
//           title: const Text('Ukranian'),
//           onTap: () {
//             context.read<LanguageCubit>().changeLanguage(Language.ukrainian);
//             Navigator.pop(context); // Повертаємося на попередній екран
//           },
//         ),
//       ],
//     ),
//   );
// }

Future showLanguageAlertDialog({required BuildContext context}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Center(
              child: Text(AppLocalizations.of(context)!.change_language)),
          backgroundColor:
          AppColorThemeBraunBlack
              .of(context)
              .whiteColorBackground,
          surfaceTintColor:
          AppColorThemeBraunBlack
              .of(context)
              .whiteColorBackground,
          children: [
            TextButton(
                onPressed: () {
                  context
                      .read<LanguageCubit>()
                      .changeLanguage(Language.english);
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        AppColorThemeBraunBlack.of(context).lightBraunColor100)
                ),
                child: Text(AppLocalizations.of(context)!.english)),
            const Padding(
              padding:  EdgeInsets.symmetric(horizontal: 15.0),
              child: Divider(),
            ),
            TextButton(
                onPressed: () {
                  context
                      .read<LanguageCubit>()
                      .changeLanguage(Language.ukrainian);
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        AppColorThemeBraunBlack.of(context).lightBraunColor100)
                ),
                child: Text(AppLocalizations.of(context)!.ukrainian))
          ],
        );
      });
}
