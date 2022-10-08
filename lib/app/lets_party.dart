import 'package:flutter/material.dart';
import 'package:lets_party/app/create_your_party/create_party_screen.dart';
import 'package:lets_party/app/home/home_screen.dart';
import 'package:lets_party/app/home/home_screen_bloc.dart';
import 'package:lets_party/app/items_page/items_page_screen.dart';
import 'package:lets_party/app/login/login_screen.dart';
import 'package:lets_party/app/party_invited/party_invited_screen.dart';
import 'package:lets_party/constants/app_colors.dart';
import 'package:localization/localization.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocalJsonLocalization.delegate.directories = ['lib/i18n'];

    return MaterialApp(
      localizationsDelegates: [
        // delegate from flutter_localization
        // GlobalMaterialLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate,
        // GlobalCupertinoLocalizations.delegate,
        // delegate from localization package.
        LocalJsonLocalization.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
      ],
      builder: (context, child) => ResponsiveWrapper.builder(
    child,
    maxWidth: 1200,
    minWidth: 480,
    defaultScale: true,
    breakpoints: [
    ResponsiveBreakpoint.resize(480, name: MOBILE),
    ResponsiveBreakpoint.autoScale(800, name: TABLET),
    ResponsiveBreakpoint.resize(1000, name: DESKTOP),
    ],),
      title: 'Flutter Demo',
      theme: appThemeData,
      home: MyHomePage(),
    );
  }
}
