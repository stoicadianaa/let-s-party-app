import 'package:flutter/cupertino.dart';
import 'package:lets_party/core/model/party_invites_model.dart';
import 'package:lets_party/core/model/party_model.dart';
import 'package:lets_party/core/service/realtime_database_service.dart';

class PartyHostBloc extends ChangeNotifier {
  PartyModel? party;
  String? hostName;
  PartyGuests? partyGuests;
  final RealtimeDatabaseService _service = RealtimeDatabaseService();

  PartyHostBloc(String partyID) {
    loadParty(partyID);
  }

  Future<void> loadParty(String partyID) async {
      party = await _service.getPartyDetails(partyID);
      hostName = (await _service.getUserFromFirebase(party!.hostEmail!)).name;
      partyGuests = await _service.getPartyGuests(partyID);
      notifyListeners();
  }
}
