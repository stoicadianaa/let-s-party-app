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
          FirebaseFirestore.instance.collection("users/").doc(user.email).set({
            "name" : user.name,
            "birthday": user.birthday
          });
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
            id: doc.id,);
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
    final firestoreDoc = await FirebaseFirestore.instance.doc("users/$email").get();
    return UserModel.fromQueryDocumentSnapshot(firestoreDoc, email);
  }

  Future<PartyGuests> getPartyGuests(String partyID) async {
    final firestoreDoc = await FirebaseFirestore.instance
        .collection("parties/")
        .doc(partyID)
        .get();

    final PartyGuests partyGuests = await PartyGuests.fromQueryDocumentSnapshot(firestoreDoc);

    return partyGuests;
  }

  static Future<String> getProfileImage(String email) async {
    String imageURL;
    try {
      final storageRef = FirebaseStorage.instance.ref();
      imageURL = await storageRef.child("profile_photos/$email.jpeg").getDownloadURL();
    } on Exception {
      imageURL = "https://www.macmillandictionary.com/us/external/slideshow/full/Grey_full.png";
    }
    return imageURL;
  }
}
