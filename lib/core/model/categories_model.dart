import 'package:lets_party/core/model/item_model.dart';

class CategoriesModel {
  late String categoryName;
  List<ItemModel> items = [];

  CategoriesModel(this.categoryName, this.items);

  CategoriesModel.fromMap(Map category) {
    categoryName = category["categoryName"] as String;
    for(final item in category["items"] as List) {
      items.add(ItemModel.fromMap(item as Map));
    }
  }
}
