import 'package:flutter/cupertino.dart';
import 'package:lets_party/core/service/realtime_database_service.dart';

class HomeScreenBloc extends ChangeNotifier {
  final RealtimeDatabaseService _databaseService = RealtimeDatabaseService();
  Map<dynamic, dynamic> listOfParties = {};
  HomeScreenBloc() {
    getListOfParties();
  }

  void getListOfParties () async {
    listOfParties = await _databaseService.getAllParties();
    notifyListeners();
  }

}