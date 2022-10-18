import 'package:flutter/cupertino.dart';
import 'package:lets_party/core/model/categories_model.dart';
import 'package:lets_party/core/service/realtime_database_service.dart';

class NeededItemsBloc extends ChangeNotifier {
  final RealtimeDatabaseService _databaseService = RealtimeDatabaseService() ;
  List<CategoriesModel> listOfNeededItems = [];
  Map<String, int> listOfItemsToBring = {};

  bool loadingDone = false;

  NeededItemsBloc(String partyID) {
    loadParty(partyID);
  }

  Future<void> loadParty(String partyID) async {
    listOfNeededItems = await _databaseService.getListOfNeededItems(partyID);
    listOfItemsToBring = await _databaseService.getListOfItemsToBring(partyID);
    loadingDone = true;
    notifyListeners();
  }
}
