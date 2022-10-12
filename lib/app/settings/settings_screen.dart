import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_party/app/edit_profile/edit_profile_screen.dart';
import 'package:lets_party/app/login/login_screen.dart';
import 'package:lets_party/constants/app_colors.dart';
import 'package:lets_party/constants/app_dimens.dart';
import 'package:lets_party/constants/app_styles.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "settings",
            style: AppStyles.appBarStyle,
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leadingWidth: 80.0,
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
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppDimens.padding_2x),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              MaterialButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(),
                  ),
                ),
                child: const SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppDimens.padding_2x,
                    ),
                    child: Text(
                      "Edit your profile",
                      style: AppStyles.bodyStyle,
                    ),
                  ),
                ),
              ),
              const Divider(),
              MaterialButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppDimens.padding_2x,
                    ),
                    child: Text(
                      "Log Out",
                      style: AppStyles.bodyStyle,
                    ),
                  ),
                ),
              ),
              const Divider()
            ],
          ),
        ),
      ),
    );
  }
}
