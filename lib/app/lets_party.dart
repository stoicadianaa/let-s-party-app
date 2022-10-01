import 'package:flutter/material.dart';
import 'package:lets_party/app/home/home_screen.dart';
import 'package:lets_party/constants/app_colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appThemeData,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
