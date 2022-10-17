import 'package:flutter/widgets.dart';
import 'package:lets_party/core/model/party_model.dart';
import 'package:lets_party/core/service/realtime_database_service.dart';

class PartyInvitedBloc extends ChangeNotifier {
  PartyModel? party;
  String? hostName;
  final RealtimeDatabaseService _service = RealtimeDatabaseService();

  PartyInvitedBloc(String partyID) {
    loadParty(partyID);
  }

  void setStatusToGoing() {
    _service.setStatus(party!.id!, "going");
  }

  void setStatusToNotGoing() {
    _service.setStatus(party!.id!, "not going");
  }

  Future<void> loadParty(String partyID) async {
    party = await _service.getPartyDetails(partyID);
    hostName = (await _service.getUserFromFirebase(party!.hostEmail!)).name;
    notifyListeners();
  }

}
