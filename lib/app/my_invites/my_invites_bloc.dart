import 'package:flutter/material.dart';
import 'package:lets_party/core/model/party_model.dart';
import 'package:lets_party/core/service/realtime_database_service.dart';

class MyInvitesBloc extends ChangeNotifier {

  List<String> partyIDs = [];
  final RealtimeDatabaseService _service = RealtimeDatabaseService();
  final List<PartyModel> invitedParties = [];
  bool isLoadingDone = false;


  MyInvitesBloc() {
    loadScreen();
  }

  Future<void> loadScreen() async {
    partyIDs = await _service.getAllInvitesForUser();

    for(final String id in partyIDs) {
      invitedParties.add(await _service.getPartyDetails(id));
    }
    isLoadingDone = true;
    notifyListeners();
  }
}
