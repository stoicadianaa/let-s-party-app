import 'package:flutter/material.dart';

const Color gamboge = Color(0xFFEA980B);
const Color indianRed = Color(0xFFE15554);
const Color blueYonder = Color(0xFF456EB8);
const Color babyPowder = Color(0xFFF7F7F2);
const Color jet = Color(0xFF292929);

ThemeData appThemeData = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(primary: gamboge, secondary: babyPowder),
  primaryColor: gamboge,
);
