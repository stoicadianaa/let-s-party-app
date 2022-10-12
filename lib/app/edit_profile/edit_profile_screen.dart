import 'package:flutter/material.dart';
import 'package:lets_party/app/components/input_field_widget.dart';
import 'package:lets_party/constants/app_colors.dart';
import 'package:lets_party/constants/app_dimens.dart';
import 'package:lets_party/constants/app_styles.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  String? _name;

  @override
  Widget build(BuildContext context) {
    const imageLink =
        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "profile",
          style: AppStyles.appBarStyle.copyWith(color: babyPowder),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  color: gamboge,
                  height: 200.0,
                ),
                Positioned(
                  top: 100.0,
                  left: screenWidth / 4,
                  child: Container(
                    height: screenWidth / 2,
                    width: screenWidth / 2,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(imageLink),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: screenWidth / 4 + 50.0,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Change your profile picture",
                style: AppStyles.bodyStyle.copyWith(color: Colors.grey[300]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimens.padding_2x),
              child: Column(
                children: [
                  InputField(
                    hintText: "Name",
                    onChanged: (val) {
                      _name = val;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (email != null && email != '') {
                        return null;
                      }
                      return "Invalid email address";
                    },
                  ),
                  const SizedBox(
                    height: AppDimens.padding_2x,
                  ),
                  InputField(
                    hintText: "Password",
                    onChanged: (val) {
                      _name = val;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (email != null && email != '') {
                        return null;
                      }
                      return "Invalid email address";
                    },
                  ),
                  const SizedBox(
                    height: AppDimens.padding_2x,
                  ),
                  InputField(
                    hintText: "Retype password",
                    onChanged: (val) {
                      _name = val;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (email != null && email != '') {
                        return null;
                      }
                      return "Invalid email address";
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.padding,
          vertical: AppDimens.padding_3x,
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            fixedSize:
                MaterialStateProperty.all(const Size(double.infinity, 60.0)),
          ),
          child: const Text("Save changes"),
        ),
      ),
    );
  }
}
