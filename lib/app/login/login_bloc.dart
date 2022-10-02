import 'package:flutter/material.dart';
import 'package:lets_party/core/service/firebase_auth_service.dart';
import 'package:provider/provider.dart';

class LoginBloc extends ChangeNotifier {
  final FirebaseAuthService _firebaseService = FirebaseAuthService();
  bool visiblePassword = false;

  Future<void> login(
      BuildContext context, String? email, String? password) async {
    final String? errorMessage =
        await _firebaseService.mailSignIn(email, password);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage ?? "Authentication successful"),
      ),
    );
  }

  void changePasswordVisibility() => visiblePassword = !visiblePassword;
}