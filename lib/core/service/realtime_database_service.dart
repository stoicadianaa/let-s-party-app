import 'package:firebase_database/firebase_database.dart';
import 'package:lets_party/core/model/categories_model.dart';
import 'package:lets_party/core/model/user_model.dart';

class RealtimeDatabaseService {
  List<CategoriesModel> listOfCategories = [];
  bool loadingDone = false;
  RealtimeDatabaseService();

  Future<String?> setUserInfo(UserModel user) async {
    final DatabaseReference usersRef = FirebaseDatabase.instance
        .ref("users/${user.email!.replaceAll(".", "")}");
    try {
      if (user.birthday == null) return "Empty date";
      if (user.name == null) return "Empty name";
      await usersRef.set(user.toJson());
      return null;
    } catch (ex) {
      return ex.toString();
    }
  }

  Future<void> getCategories() async {
    final ref = FirebaseDatabase.instance.ref("categories/");
    final event = await ref.once();
    final Map<String, dynamic> categories =
        Map<String, dynamic>.from(event.snapshot.value as Map);
    for (final category in categories["listOfCategories"] as List) {
      listOfCategories.add(
        CategoriesModel.fromMap(category as Map),
      );
    }
    loadingDone = true;
  }
}
