import 'package:flutter/material.dart';

import 'color_pallet_widget.dart';

// abstract class for get color app
abstract class AppColorTheme {
  // ============== Main Braun Colors =================
  Color get lightBraunColor100;

  Color get lightBraunColor80;

  Color get lightBraunColor60;

  Color get lightBraunColor40;

  Color get lightBraunColor30;

  Color get lightBraunColor20;

  Color get lightBraunColor10;

  // ============== Main Black Colors =================
  Color get blackColor100;

  Color get blackColor80;

  Color get blackColor60;

  Color get blackColor40;

  Color get blackColor30;

  Color get blackColor20;

  Color get blackColor10;

//  ========= Typography Colors ===========
  Color get whiteColorBackground;
}

class AppPalletBraun {
  static const Color lightBraunColor100 = Color(0xFFC68E17);
  static const Color lightBraunColor80 = Color(0xFFD2A546);
  static const Color lightBraunColor60 = Color(0xFFD7B15E);
  static const Color lightBraunColor40 = Color(0xFFE3C88D);
  static const Color lightBraunColor30 = Color(0xFFE9D3A5);
  static const Color lightBraunColor20 = Color(0xFFEFDFBD);
  static const Color lightBraunColor10 = Color(0xFFF4EAD4);
}

class AppPalletBlack {
  static const Color blackColor100 = Color(0xFF000000);
  static const Color blackColor80 = Color(0xFF242424);
  static const Color blackColor60 = Color(0xFF484848);
  static const Color blackColor40 = Color(0xFF6C6C6C);
  static const Color blackColor30 = Color(0xFF909090);
  static const Color blackColor20 = Color(0xFFB4B4B4);
  static const Color blackColor10 = Color(0xFFD8D8D8);
}

class AppColorThemeBraunBlack implements AppColorTheme {
  static AppColorThemeBraunBlack of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ColorPaletteInherited>()!
        .palette;
  }

  @override
  // TODO: implement lightBraunColor100
  Color get lightBraunColor100 => AppPalletBraun.lightBraunColor100;

  @override
  // TODO: implement lightBraunColor80
  Color get lightBraunColor80 => AppPalletBraun.lightBraunColor80;

  @override
  // TODO: implement lightBraunColor60
  Color get lightBraunColor60 => AppPalletBraun.lightBraunColor60;

  @override
  // TODO: implement lightBraunColor40
  Color get lightBraunColor40 => AppPalletBraun.lightBraunColor40;

  @override
  // TODO: implement lightBraunColor30
  Color get lightBraunColor30 => AppPalletBraun.lightBraunColor30;

  @override
  // TODO: implement lightBraunColor20
  Color get lightBraunColor20 => AppPalletBraun.lightBraunColor20;

  @override
  // TODO: implement lightBraunColor10
  Color get lightBraunColor10 => AppPalletBraun.lightBraunColor10;

  @override
  // TODO: implement blackColor100
  Color get blackColor100 => AppPalletBlack.blackColor100;

  @override
  // TODO: implement blackColor80
  Color get blackColor80 => AppPalletBlack.blackColor80;

  @override
  // TODO: implement blackColor60
  Color get blackColor60 => AppPalletBlack.blackColor60;

  @override
  // TODO: implement blackColor40
  Color get blackColor40 => AppPalletBlack.blackColor60;

  @override
  // TODO: implement blackColor30
  Color get blackColor30 => AppPalletBlack.blackColor30;

  @override
  // TODO: implement blackColor20
  Color get blackColor20 => AppPalletBlack.blackColor20;

  @override
  // TODO: implement blackColor10
  Color get blackColor10 => AppPalletBlack.blackColor10;

  @override
  // TODO: implement whiteColorBackground
  Color get whiteColorBackground => const Color(0xFFF5F5F5);
}
