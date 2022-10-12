import 'package:firebase_auth/firebase_auth.dart';
import 'package:lets_party/core/model/user_model.dart';
import 'package:lets_party/core/service/firebase_auth_service.dart';
import 'package:lets_party/core/service/realtime_database_service.dart';

class EditProfileBloc extends ChangeNotifier{
  UserModel user;
  String profilePicture;
  RealtimeDatabaseService _service = RealtimeDatabaseService();

  EditProfileBloc() {
    loadScreen();

  }

  loadScreen () async {
    user = await _service.getUserFromFirebase(FirebaseAuth.instance.currentUser!.email!);

  }

}
