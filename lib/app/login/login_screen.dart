import 'package:flutter/material.dart';
import 'package:lets_party/app/components/input_field_widget.dart';
import 'package:lets_party/app/login/login_bloc.dart';
import 'package:lets_party/constants/app_dimens.dart';
import 'package:lets_party/constants/app_styles.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  LoginBloc bloc = LoginBloc();
  final bool _visiblePassword = false;

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
              "log in".i18n(),
              style: AppStyles.appBarStyle,
            ),
            centerTitle: true,
            toolbarHeight: 80.0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(AppDimens.padding_2x),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  InputField(
                    hintText: "Email".i18n(),
                    onChanged: (val) {
                      _email = val;
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
                      _password = val;
                    },
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return "Empty password";
                      }
                      return null;
                    },
                    obscureText: !_visiblePassword,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: Consumer<LoginBloc>(
                      builder: (context, bloc, child) {
                        return TextButton(
                          onPressed: () => bloc.changePasswordVisibility(),
                          child: Text(
                            _visiblePassword ? "Hide" : "Show",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(AppDimens.padding_2x),
            child: ElevatedButton(
              onPressed: () => bloc.login(context, _email, _password),
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
              child: const Text("Log in"),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }
}
