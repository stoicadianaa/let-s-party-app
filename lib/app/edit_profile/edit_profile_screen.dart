import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_party/app/components/input_field_widget.dart';
import 'package:lets_party/app/edit_profile/edit_profile_bloc.dart';
import 'package:lets_party/constants/app_colors.dart';
import 'package:lets_party/constants/app_dimens.dart';
import 'package:lets_party/constants/app_styles.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final _editProfileKey = GlobalKey<FormState>();
  String? _password1;
  String? _name;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (BuildContext context) => EditProfileBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "profile",
            style: AppStyles.appBarStyle.copyWith(color: babyPowder),
          ),
        ),
        body: SafeArea(
          child: Consumer<EditProfileBloc>(
            builder: (context, bloc, child) {
              if (bloc.isLoadingDone) {
                return ListView(
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
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(bloc.profilePicture),
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
                      onPressed: () async {
                        await bloc.pickImage();
                      },
                      child: Text(
                        "Change your profile picture",
                        style: AppStyles.bodyStyle
                            .copyWith(color: Colors.grey[300]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppDimens.padding_2x),
                      child: Form(
                        key: _editProfileKey,
                        child: Column(
                          children: [
                            InputField(
                              hintText: "Name",
                              onChanged: (val) {
                                _name = val;
                                print(_name);
                              },
                              validator: (name) {
                                if (name == '') {
                                  return "Empty name";
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(
                              height: AppDimens.padding_2x,
                            ),
                            InputField(
                              hintText: "Password",
                              onChanged: (val) {
                                _password1 = val;
                                print("password1: $_password1");
                              },
                              validator: (password) {
                                if (password == '')
                                  return "The password is empty";
                                else
                                  return null;
                              },
                              obscureText: !bloc.visiblePassword,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.visiblePassword,
                            ),
                            const SizedBox(
                              height: AppDimens.padding_2x,
                            ),
                            // InputField(
                            //   hintText: "Retype password",
                            //   onChanged: (val) {
                            //     _password2 = val ?? '';
                            //   },
                            //   textInputAction: TextInputAction.next,
                            //   keyboardType: TextInputType.emailAddress,
                            //   validator: (password) {
                            //     if (_password1 == _password2) {
                            //       return null;
                            //     }
                            //     return "The passwords are different";
                            //   },
                            //   obscureText: !bloc.visiblePassword,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.padding,
            vertical: AppDimens.padding_3x,
          ),
          child: ElevatedButton(
            onPressed: () async {
              bool isValidated = _editProfileKey.currentState!.validate();
              if (isValidated) {
                try {
                  print("here: $_name");
                  await EditProfileBloc.changeUserNameAndPassword( _password1!,
                    _name!,
                  );
                  print("here2");
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              }
            },
            style: ButtonStyle(
              fixedSize:
                  MaterialStateProperty.all(const Size(double.infinity, 60.0)),
            ),
            child: const Text("Save changes"),
          ),
        ),
      ),
    );
  }
}
