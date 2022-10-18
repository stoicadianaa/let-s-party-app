import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lets_party/core/model/categories_model.dart';
import 'package:lets_party/core/model/item_model.dart';
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

  //categories w/o loading done thing
  static Future<List<CategoriesModel>> getCategories2() async {
    List<CategoriesModel> categoriesList = [];
    final ref = FirebaseDatabase.instance.ref("categories/");
    final event = await ref.once();
    final Map<String, dynamic> categories =
        Map<String, dynamic>.from(event.snapshot.value! as Map);
    for (final category in categories["listOfCategories"] as List) {
      categoriesList.add(
        CategoriesModel.fromMap(category as Map),
      );
    }
    return categoriesList;
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
    String imageURL =
        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
    final storageRef = FirebaseStorage.instance.ref();
    final bool hasImage = (await storageRef.child("profile_photos/").listAll())
        .items
        .toString()
        .contains(email);

    if (hasImage) {
      imageURL =
          await storageRef.child("profile_photos/$email.jpeg").getDownloadURL();
    }

    return imageURL;
  }

  Future<void> setProfileImage(String email, File file) async {
    final storageRef = FirebaseStorage.instance.ref();
    final imageStorageRef = storageRef.child("profile_photos/$email.jpeg");

    imageStorageRef.putFile(file);
  }

  Future<List<UserModel>> getAllUsers() async {
    final List<UserModel> allUsersList = <UserModel>[];
    return allUsersList;
  }

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

  Future<List<String>> getAllInvitesForUser() async {
    final email = FirebaseAuth.instance.currentUser!.email;
    final List<String> invitedPartiesIDs = [];
    await FirebaseFirestore.instance
        .collection('parties')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (final doc in querySnapshot.docs) {
        final partyInvitesInfo = doc['guests'].toString();
        if (partyInvitesInfo.contains("$email: invited")) {
          invitedPartiesIDs.add(doc.id);
        }
      }
    });
    return invitedPartiesIDs;
  }

  Future<List<String>> getAllGoingParties() async {
    final email = FirebaseAuth.instance.currentUser!.email;
    final List<String> invitedPartiesIDs = [];
    await FirebaseFirestore.instance
        .collection('parties')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (final doc in querySnapshot.docs) {
        final partyInvitesInfo = doc['guests'].toString();
        if (partyInvitesInfo.contains("$email: coming")) {
          invitedPartiesIDs.add(doc.id);
        }
      }
    });
    return invitedPartiesIDs;
  }

  void setStatus(String partyID, String status) {
    FirebaseFirestore.instance.collection("parties").doc(partyID).update({
      "guests": {"${FirebaseAuth.instance.currentUser!.email}": status}
    });
  }

  Future<List<CategoriesModel>> getListOfNeededItems(String partyID) async {
    final Map<String, int> listOfItems = {};
    List<CategoriesModel> listOfNeededItems = [];
    final databaseResponse = (await FirebaseFirestore.instance
            .collection('parties')
            .doc(partyID)
            .get())['needed'].toString();

    final List<String> listOfSeparatedStrings =
        databaseResponse.substring(1, databaseResponse.length - 1).split(", ");

    for (String item in listOfSeparatedStrings) {
      listOfItems[item.split(": ")[0]] = int.parse(item.split(": ")[1]);
    }

    final categoriesList = await getCategories2();

    for (final CategoriesModel category in categoriesList) {
      const categoryAlreadyAdded = false;
      for (final ItemModel item in category.items) {
        if (listOfItems.containsKey(item.name)) {
          if (!categoryAlreadyAdded) {
            listOfNeededItems.add(CategoriesModel(category.categoryName, []));
          }
          listOfNeededItems.last.items.add(item);
        }
      }
    }

    return listOfNeededItems;
  }

  Future<Map<String, int>> getListOfItemsToBring(String partyID) async {
    final String email = FirebaseAuth.instance.currentUser!.email!;
    final firestoreInstance =
        (await FirebaseFirestore.instance.collection('users')).doc(email);

    Map<String, int> finalItemsList = {};

    bool condition = (await firestoreInstance.get()).data()!.containsKey(partyID);

    if(condition)
    {
      List<String> itemsAsString =
          ((await firestoreInstance.get())[partyID].toString())
              .replaceAll("{", "")
              .replaceAll("}", "")
              .split(",");

      for (String item in itemsAsString) {
        List<String> itemData = item.split(": ");
        finalItemsList.addAll({itemData[0].trim(): int.parse(itemData[1])});
      }

    }

    return finalItemsList;
  }

  Future<void> addItemToParty(Map<String, int> currentList, String itemName, String partyID,
      int valueToIncrement) async {
    final firestore = await (FirebaseFirestore.instance.collection('users'))
        .doc(FirebaseAuth.instance.currentUser!.email);
    if (currentList.containsKey(itemName)) {
      currentList[itemName] = currentList[itemName]! + valueToIncrement;
    } else {
      currentList[itemName] = 1;
    }

    firestore.update({partyID: currentList});

    // if (!isPartyInUser) {
    //   firestoreInstance.update({partyID: {
    //     itemName: 0
    //   }});
    // }

    // (await FirebaseFirestore.instance.collection('users')).doc(email).update({partyID: {
    //   itemName: FieldValue.increment(valueToIncrement)
    // }});
  }

  static Future<int> getNeededQuantity(String itemName, String partyID) async {

    return int.parse((await FirebaseFirestore.instance.collection('parties').doc(partyID).get())[itemName].toString());

  }
}
