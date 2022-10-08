class ItemModel {
  late String imageLink;
  late String name;
  late double price;

  ItemModel(this.imageLink, this.name, this.price);

  ItemModel.fromMap(Map item) {
    imageLink = item["imageLink"] as String;
    price = double.parse(item["price"].toString());
    name = item["name"] as String;
  }
}
