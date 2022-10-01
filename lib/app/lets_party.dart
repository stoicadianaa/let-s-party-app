import 'package:flutter/material.dart';
import 'package:lets_party/app/login/login_screen.dart';
import 'package:lets_party/constants/app_colors.dart';
import 'package:localization/localization.dart';

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
      title: 'Flutter Demo',
      theme: appThemeData,
      home: const LoginScreen(),
    );
  }
}
