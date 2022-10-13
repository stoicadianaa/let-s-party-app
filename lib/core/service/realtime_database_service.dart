import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:lets_party/core/model/categories_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lets_party/core/model/party_model.dart';
import 'package:lets_party/core/model/user_model.dart';

class RealtimeDatabaseService {
  List<CategoriesModel> listOfCategories = [];
  Map allParties = {};
  List<PartyModel> listOfPossibleParties = [];
  List<PartyModel> listOfHostedParties = [];
  bool loadingDone = false;
  String currentUser = "stevenBoss@gmail.com";

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

  Future<Map> getAllParties() async {
    print('printeaza ma ceva');
    final reference = await FirebaseFirestore.instance
        .collection('parties')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        PartyModel partyModel = PartyModel(
          doc['description'] as String,
          doc['name'] as String,
          doc['pictureLink'] as String,
          doc['hostEmail'] as String,
          DateTime.tryParse(doc['rsvp'] as String),
          DateTime.tryParse(doc['when'] as String),
          doc['where'] as String,
          (doc['tags'] as String).split(","),
          id: doc.id
        );
        if (partyModel.isHostedByCurrentUser()) {
          listOfHostedParties.add(partyModel);
        } else {
          listOfPossibleParties.add(partyModel);
        }
      });
      final Map mapWithHostedAndPossibleParties = {};
      mapWithHostedAndPossibleParties['hosted'] = listOfHostedParties;
      mapWithHostedAndPossibleParties['possible'] = listOfPossibleParties;
      return mapWithHostedAndPossibleParties;
    });
    loadingDone = true;
    return reference;
  }

  Future<PartyModel> getPartyDetails(String partyID) async {
    PartyModel party;
    final firestoreDoc = await FirebaseFirestore.instance.collection("parties").doc(partyID).get();

    // final ref = FirebaseDatabase.instance.ref("parties/0");
    // final event = await ref.once();
    // final Map<String, dynamic> json =
    // Map<String, dynamic>.from(event.snapshot.value as Map);
    // party = PartyModel.fromMap(json);

    party = PartyModel.fromQueryDocumentSnapshot(firestoreDoc);

    return party;
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

  // Future<void> getUserFromFirebase(String email) async {
  //   var data = FirebaseFirestore.instance.doc("user/$email").get().then((value) {
  //     return value;
  //   });
  // }
}
