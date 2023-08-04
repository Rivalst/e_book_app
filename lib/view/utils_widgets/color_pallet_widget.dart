import 'package:e_book_app/config/color_theme.dart';
import 'package:flutter/material.dart';

/// Widget that provide color pallet in widget tree
///
/// Example use => AppColorThemeBraunBlack.of(context)
@immutable
class ColorPaletteInherited extends InheritedWidget {
  final AppColorThemeBraunBlack palette;

  const ColorPaletteInherited({
    required this.palette,
    required Widget child,
    super.key,
  }) : super(child: child);

  @override
  bool updateShouldNotify(ColorPaletteInherited old) => palette != old.palette;
}