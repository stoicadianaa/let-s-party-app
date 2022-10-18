import 'package:flutter/material.dart';
import 'package:lets_party/app/party_atendee/components/item_widget.dart';
import 'package:lets_party/app/party_atendee/needed_items/needed_items_bloc.dart';
import 'package:lets_party/constants/app_styles.dart';
import 'package:lets_party/core/model/categories_model.dart';
import 'package:lets_party/core/model/item_model.dart';

class ListOfItemsWidget extends StatelessWidget {
  const ListOfItemsWidget(this.category, this.bloc, this.partyID);

  final NeededItemsBloc bloc;
  final CategoriesModel category;
  final String partyID;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category.categoryName,
          style: AppStyles.categoryStyle,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 250.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: category.items.length,
            itemBuilder: (BuildContext context, int index) {
              final ItemModel item = category.items[index];
              return NeededItemWidget(item: item, bloc: bloc,partyID: partyID,);
            },
          ),

        )
      ],
    );
  }
}