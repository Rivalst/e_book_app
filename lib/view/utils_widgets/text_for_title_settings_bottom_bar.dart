import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

String getTitle({required int index, required BuildContext context}) {
  switch (index) {
    case 0:
      return AppLocalizations.of(context)!.home;
    case 1:
      return AppLocalizations.of(context)!.discover;
    case 2:
      return AppLocalizations.of(context)!.library;
    case 3:
      return AppLocalizations.of(context)!.profile;
    default:
      return AppLocalizations.of(context)!.home;
  }
}
