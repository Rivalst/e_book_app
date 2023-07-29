import 'package:e_book_app/view/utilit_widgets/color_theme.dart';
import 'package:flutter/material.dart';

class ColorPaletteInherited extends InheritedWidget {
  final AppColorThemeBraunBlack palette;

  ColorPaletteInherited({
    required this.palette,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(ColorPaletteInherited old) => palette != old.palette;
}