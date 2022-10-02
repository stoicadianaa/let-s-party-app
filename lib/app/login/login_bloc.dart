import 'package:flutter/material.dart';
import 'package:lets_party/core/service/firebase_service.dart';

class LoginBloc extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  bool visiblePassword = false;

  Future<void> login (BuildContext context, String? email, String? password) async {
    final String? errorMessage =
    await _firebaseService.mailSignIn(email, password);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage ?? "Authentication successful"),
      ),
    );
  }

  void changePasswordVisibility() {
    visiblePassword = !visiblePassword;
    notifyListeners();
  }
}
