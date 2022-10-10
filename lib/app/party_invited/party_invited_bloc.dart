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

  Future<void> loadParty(String partyID) async {

    try {
      party = await _service.getPartyDetails(partyID);
      hostName = (await _service.getUserFromFirebase(party!.hostEmail!)).name;
    } on Exception catch (e) {
      // TODO
    }
    notifyListeners();
  }

}
