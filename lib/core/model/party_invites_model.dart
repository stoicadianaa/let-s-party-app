import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lets_party/core/model/guest_model.dart';
import 'package:lets_party/core/service/realtime_database_service.dart';

class PartyGuests {
  List<GuestModel> invited = [];
  List<GuestModel> coming = [];
  List<GuestModel> notComing = [];

  PartyGuests(this.invited, this.coming, this.notComing);

  static Future<PartyGuests> fromQueryDocumentSnapshot (
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) async {
    final PartyGuests guests = PartyGuests([],[],[]);

    for (final MapEntry entry in (doc["guests"] as Map).entries) {
      String imageRef;
      try {
        imageRef = await RealtimeDatabaseService.getProfileImage(entry.key as String);
      } catch (e) {
        imageRef = await RealtimeDatabaseService.getProfileImage("placeholder");
      }

      //TODO find another way to get name from database
      final guest = GuestModel((await RealtimeDatabaseService().getUserFromFirebase(entry.key as String)).name ?? "Unknown name", imageRef);
        if (entry.value == "invited") {
          guests.invited.add(guest);
        } else if (entry.value == "coming") {
          guests.coming.add(guest);
        } else if (entry.value == "not coming") {
          guests.notComing.add(guest);
        }
    }
    return guests;
  }
}
