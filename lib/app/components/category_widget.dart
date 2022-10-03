import 'package:flutter/material.dart';
import 'package:lets_party/app/components/item_widget.dart';
import 'package:lets_party/constants/app_styles.dart';
import 'package:lets_party/core/model/categories_model.dart';
import 'package:lets_party/core/model/item_model.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget(this.category);

  final CategoriesModel category;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category.categoryName,
          style: AppStyles.categorytyle,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 200.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: category.items.length,
            itemBuilder: (BuildContext context, int index) {
              final ItemModel item = category.items[index];
              return ItemWidget(
                title: item.name,
                price: item.price,
                imageLink: item.imageLink,
              );
            },
          ),
        )
      ],
    );
  }
}
