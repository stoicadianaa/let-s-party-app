import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lets_party/core/model/user_model.dart';
import 'package:lets_party/core/service/realtime_database_service.dart';

class EditProfileBloc extends ChangeNotifier {
  late UserModel user;
  late String profilePicture;
  final RealtimeDatabaseService _service = RealtimeDatabaseService();
  bool isLoadingDone = false;
  bool visiblePassword = false;
  bool? isImagedPicked = false;
  File? image;

  EditProfileBloc() {
    loadScreen();
  }

  //duplicate, move at mixins
  Future<void> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);
      this.image = imageTemp;
      isImagedPicked = true;
      await _service.setProfileImage(user.email!, this.image!);

      profilePicture = await RealtimeDatabaseService.getProfileImage(user.email!);

      notifyListeners();

    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> loadScreen() async {
    final String email = FirebaseAuth.instance.currentUser!.email!;
    user = await _service.getUserFromFirebase(email);
    profilePicture = await RealtimeDatabaseService.getProfileImage(email);
    isLoadingDone = true;
    notifyListeners();
  }

  static Future<void> changeUserNameAndPassword(String newPassword, String newName) async {
    final RealtimeDatabaseService _service = RealtimeDatabaseService();
    var user = FirebaseAuth.instance.currentUser;
    try {
      user!.updatePassword(newPassword);
      _service.updateUserName(newName, user.email!);
    } catch (e) {
      rethrow;
    }
  }
}
