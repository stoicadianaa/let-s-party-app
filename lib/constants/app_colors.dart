import 'package:flutter/material.dart';

import 'app_dimens.dart';

const Color gamboge = Color(0xFFEA980B);
const Color indianRed = Color(0xFFE15554);
const Color blueYonder = Color(0xFF456EB8);
const Color babyPowder = Color(0xFFF7F7F2);
const Color jet = Color(0xFF292929);

ThemeData appThemeData = ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(primary: gamboge, secondary: babyPowder),
    primaryColor: gamboge,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      toolbarHeight: 80.0,
      elevation: 0.0,
    ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimens.roundedButtonCorners),
          ),
        ),
      ),
    ),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: gamboge,
  )
);
