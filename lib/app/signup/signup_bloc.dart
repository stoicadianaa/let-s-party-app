import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_party/core/model/user_model.dart';
import 'package:lets_party/core/service/firebase_auth_service.dart';
import 'package:lets_party/core/service/realtime_database_service.dart';

class SignUpBloc extends ChangeNotifier {
  UserModel userModel = UserModel.allFields(null, null, null);
  String? password;
  bool visiblePassword = false;
  final RealtimeDatabaseService _databaseService = RealtimeDatabaseService();
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  Future<String> createAccount(BuildContext context) async {
    String? message;
    try {
      message = await _firebaseAuthService.createAccount(userModel.email, password);
      message ??= await _databaseService.setUserInfo(userModel);
    } on FirebaseAuthException catch (ex) {
      message = "${ex.code}: ${ex.message}";
    }
    return message ?? "Authentication successful";
  }

  String getDateFormatted(DateTime date) =>
      "${date.day.toString()}/${date.month.toString()}/${date.year.toString()}";

  void changePasswordVisibility() {
    visiblePassword = !visiblePassword;
    notifyListeners();
  }

  Future<void> pickDate(BuildContext context) async {
    DateTime? date;
    date = await showDatePicker(
      context: context,
      initialDate: DateTime.utc(DateTime.now().year - 20),
      firstDate: DateTime.utc(DateTime.now().year - 80),
      lastDate: DateTime.utc(DateTime.now().year - 10),
    );
    if(date != null) {
      userModel.birthday = getDateFormatted(date);
    }
    notifyListeners();
  }
}
