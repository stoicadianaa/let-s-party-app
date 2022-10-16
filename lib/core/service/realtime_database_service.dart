import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lets_party/core/model/categories_model.dart';
import 'package:lets_party/core/model/party_invites_model.dart';
import 'package:lets_party/core/model/party_model.dart';
import 'package:lets_party/core/model/user_model.dart';

class RealtimeDatabaseService {
  List<CategoriesModel> listOfCategories = [];
  Map allParties = {};
  List<PartyModel> listOfPossibleParties = [];
  List<PartyModel> listOfHostedParties = [];
  bool loadingDone = false;

  Future<String?> setUserInfo(UserModel user) async {
    try {
      FirebaseFirestore.instance
          .collection("users/")
          .doc(user.email)
          .set({"name": user.name, "birthday": user.birthday});
    } on Exception catch (e) {
      return e.toString();
    }
    return null;
  }

  Future<void> getCategories() async {
    final ref = FirebaseDatabase.instance.ref("categories/");
    final event = await ref.once();
    final Map<String, dynamic> categories =
        Map<String, dynamic>.from(event.snapshot.value! as Map);
    for (final category in categories["listOfCategories"] as List) {
      listOfCategories.add(
        CategoriesModel.fromMap(category as Map),
      );
    }
    loadingDone = true;
  }

  Future<Map> getAllParties() async {
    final reference = await FirebaseFirestore.instance
        .collection('parties')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (final doc in querySnapshot.docs) {
        final PartyModel partyModel = PartyModel(
          doc['description'] as String,
          doc['name'] as String,
          doc['pictureLink'] as String,
          doc['hostEmail'] as String,
          DateTime.tryParse(doc['rsvp'] as String),
          DateTime.tryParse(doc['when'] as String),
          doc['where'] as String,
          (doc['tags'] as String).split(","),
          id: doc.id,
        );
        if (partyModel.isHostedByCurrentUser()) {
          listOfHostedParties.add(partyModel);
        } else {
          listOfPossibleParties.add(partyModel);
        }
      }
      final Map mapWithHostedAndPossibleParties = {};
      mapWithHostedAndPossibleParties['hosted'] = listOfHostedParties;
      mapWithHostedAndPossibleParties['possible'] = listOfPossibleParties;
      return mapWithHostedAndPossibleParties;
    });
    loadingDone = true;
    return reference;
  }

  Future<PartyModel> getPartyDetails(String partyID) async {
    final firestoreDoc = await FirebaseFirestore.instance
        .collection("parties")
        .doc(partyID)
        .get();

    return PartyModel.fromQueryDocumentSnapshot(firestoreDoc);
  }

  Future<UserModel> getUserFromFirebase(String email) async {
    final firestoreDoc =
        await FirebaseFirestore.instance.doc("users/$email").get();
    return UserModel.fromQueryDocumentSnapshot(firestoreDoc, email);
  }

  Future<PartyGuests> getPartyGuests(String partyID) async {
    final firestoreDoc = await FirebaseFirestore.instance
        .collection("parties/")
        .doc(partyID)
        .get();

    final PartyGuests partyGuests =
        await PartyGuests.fromQueryDocumentSnapshot(firestoreDoc);

    return partyGuests;
  }

  static Future<String> getProfileImage(String email) async {
    String imageURL = "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
    final storageRef = FirebaseStorage.instance.ref();
    final bool hasImage = (await storageRef.child("profile_photos/").listAll()).items.toString().contains(email);

    if(hasImage) {
      imageURL = await storageRef.child("profile_photos/$email.jpeg").getDownloadURL();
    }

    return imageURL;
  }

  Future<void> setProfileImage(String email, File file) async {
    final storageRef = FirebaseStorage.instance.ref();
    final imageStorageRef = storageRef.child("profile_photos/$email.jpeg");

    imageStorageRef.putFile(file);
  }

  Future<List<UserModel>> getAllUsers() async {
    List<UserModel> allUsersList = <UserModel>[];
    final usersList = await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        UserModel userModel = UserModel.allFields(
          doc['name'] as String,
          doc.id as String,
          doc['birthday'] as String,
        );
        allUsersList.add(userModel);
      });
      return allUsersList;
    });
    return allUsersList;
  }

  static Future<String> getProfileImage(String email) async {
    String imageURL = "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
    final storageRef = FirebaseStorage.instance.ref();
    final bool hasImage = (await storageRef.child("profile_photos/").listAll()).items.toString().contains(email);

    if(hasImage) {
      imageURL = await storageRef.child("profile_photos/$email.jpeg").getDownloadURL();
    }

    return imageURL;
  }

  // Future<void> getUserFromFirebase(String email) async {
  //   var data = FirebaseFirestore.instance.doc("user/$email").get().then((value) {
  //     return value;
  //   });
  // }

  Future<String?> updateUserName(String name, String email) async {
    try {
      FirebaseFirestore.instance
          .collection("users/")
          .doc(email)
          .update({"name": name});
    } on Exception catch (e) {
      return e.toString();
    }
    return null;
  }

}
