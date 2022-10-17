import 'package:flutter/cupertino.dart';
import 'package:lets_party/core/model/party_model.dart';
import 'package:lets_party/core/service/realtime_database_service.dart';

class HomeScreenBloc extends ChangeNotifier {
  final RealtimeDatabaseService _databaseService = RealtimeDatabaseService();
  Map<dynamic, dynamic> listOfParties = {};
  List<PartyModel> goingParties = [];

  HomeScreenBloc() {
     loadScreen();
  }

  Future<void> getListOfParties () async {
    listOfParties = await _databaseService.getAllParties();
  }

  Future<void> loadScreen() async {
    List<String> goingPartiesIDs = [];
    await getListOfParties();
    goingPartiesIDs = await _databaseService.getAllGoingParties();
    for(String id in goingPartiesIDs) {
      final PartyModel party = await _databaseService.getPartyDetails(id);
      goingParties.add(party);
    }
    notifyListeners();
  }
}
