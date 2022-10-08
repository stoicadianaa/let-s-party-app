import 'package:flutter/material.dart';
import 'package:lets_party/app/components/input_field_widget.dart';
import 'package:lets_party/app/signup/signup_bloc.dart';
import 'package:lets_party/constants/app_colors.dart';
import 'package:lets_party/constants/app_dimens.dart';
import 'package:lets_party/constants/app_styles.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  //daca sunt erori, poate sunt de la final
  final SignUpBloc bloc = SignUpBloc();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => bloc,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0.0,
            title: Text(
              "Sign Up".i18n().toLowerCase(),
              style: AppStyles.appBarStyle,
            ),
            leading: TextButton (
              child: Text("Back".i18n()),
              onPressed: () => Navigator.pop(context),
            ),
            centerTitle: true,
            toolbarHeight: 80.0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(AppDimens.padding_2x),
            child: Form(
              key: _formKey,
              child: Consumer<SignUpBloc>(
                builder: (context, signupBloc, child) {
                  return ListView(
                    children: [
                      InputField(
                        hintText: "Name".i18n(),
                        onChanged: (val) {
                          bloc.userModel.name = val;
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        validator: (name) {
                          if (name != null && name != '') {
                            return null;
                          }
                          return "Invalid name";
                        },
                      ),
                      const SizedBox(
                        height: AppDimens.padding_2x,
                      ),
                      InputField(
                        hintText: "Email".i18n(),
                        onChanged: (val) {
                          bloc.userModel.email = val;
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
                        hintText: "Password".i18n(),
                        onChanged: (val) {
                          bloc.password = val;
                        },
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return "Empty password";
                          }
                          return null;
                        },
                        obscureText: !bloc.visiblePassword,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon: TextButton(
                          onPressed: () => bloc.changePasswordVisibility(),
                          child: Text(
                            bloc.visiblePassword ? "Hide" : "Show",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: AppDimens.padding_2x,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await bloc.pickDate(context);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(gamboge.withOpacity(0.5)),
                        ),
                        child: Text(
                          "Birthday: ${
                              bloc.userModel.birthday ?? "Choose date"
                          }",
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(AppDimens.padding_2x),
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate() && bloc.userModel.birthday != null) {
                  final String message = await bloc.createAccount(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                    ),
                  );
                }
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                  Size(
                    MediaQuery.of(context).size.width,
                    50,
                  ),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),
              child: Text("Sign Up".i18n()),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }
}
