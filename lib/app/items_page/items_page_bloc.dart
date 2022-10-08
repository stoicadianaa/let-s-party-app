import 'package:flutter/cupertino.dart';
import 'package:lets_party/core/model/categories_model.dart';
import 'package:lets_party/core/service/realtime_database_service.dart';

class ItemsPageBloc extends ChangeNotifier {
  final RealtimeDatabaseService _databaseService = RealtimeDatabaseService() ;
  bool loadingDone = false;
  List<CategoriesModel> listOfCategories = [];

  ItemsPageBloc() {
    _databaseService.getCategories().whenComplete(() {
      loadingDone = true;
      listOfCategories = _databaseService.listOfCategories;
      notifyListeners();
    });
  }
}
