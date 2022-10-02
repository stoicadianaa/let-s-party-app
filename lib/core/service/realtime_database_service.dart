import 'package:firebase_database/firebase_database.dart';
import 'package:lets_party/core/model/user_model.dart';

class RealtimeDatabaseService {
  Future<String?> setUserInfo(UserModel user) async {
    final DatabaseReference usersRef =
        FirebaseDatabase.instance.ref("users/${user.email!.replaceAll(".", "")}");
    try {
      if (user.birthday == null) return "Empty date";
      if (user.name == null) return "Empty name";
      await usersRef.set(user.toJson());
      return null;
    } catch (ex) {
      return ex.toString();
    }
  }
}
