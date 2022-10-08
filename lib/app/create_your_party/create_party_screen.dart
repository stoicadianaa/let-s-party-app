import 'package:flutter/material.dart';
import 'package:lets_party/constants/app_colors.dart';
import 'package:lets_party/constants/app_dimens.dart';
import 'package:lets_party/gen/fonts.gen.dart';

class CreatePartyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0.0,
          leadingWidth: 100.0,
          toolbarHeight: 80.0,
          leading: TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Back",
              style: TextStyle(
                color: gamboge,
                fontSize: 20.0,
              ),
            ),
          ),
          title: const Text(
            "create party",
            style: TextStyle(
              color: jet,
              fontSize: 42.0,
              fontFamily: FontFamily.keepOnTrucking,
            ),
          ),
          centerTitle: true,
        ),
      ),
    );
  }
}
