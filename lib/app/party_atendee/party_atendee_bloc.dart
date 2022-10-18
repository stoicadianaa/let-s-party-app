import 'package:flutter/material.dart';
import 'package:lets_party/core/model/party_model.dart';
import 'package:lets_party/core/service/realtime_database_service.dart';

import '../../core/model/guest_model.dart';

class PartyAtendeeBloc extends ChangeNotifier{
  PartyModel? party;
  String? hostName;
  List<GuestModel> partyGuests = [];
  final RealtimeDatabaseService _service = RealtimeDatabaseService();
  bool loadingDone = false;

  PartyAtendeeBloc(String partyID) {
    loadParty(partyID);
  }

  Future<void> loadParty(String partyID) async {
    party = await _service.getPartyDetails(partyID);
    hostName = (await _service.getUserFromFirebase(party!.hostEmail!)).name;
    partyGuests = (await _service.getPartyGuests(partyID)).coming;
    loadingDone = true;
    notifyListeners();
  }
}
