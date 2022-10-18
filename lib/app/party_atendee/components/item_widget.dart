import 'package:flutter/material.dart';
import 'package:lets_party/app/party_atendee/choose_quantity_screen/choose_quantity_screen.dart';
import 'package:lets_party/app/party_atendee/needed_items/needed_items_bloc.dart';
import 'package:lets_party/constants/app_dimens.dart';
import 'package:lets_party/constants/app_styles.dart';
import 'package:lets_party/core/model/item_model.dart';

class NeededItemWidget extends StatelessWidget {
  NeededItemWidget({
    required this.item,
    this.quantityVisible = false, required this.bloc, required this.partyID,

  });

  final ItemModel item;
  final NeededItemsBloc bloc;
  final String partyID;
  bool quantityVisible;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      //TODO: add party id
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseQuantityScreen(
      itemModel: item,
      partyID: partyID, bloc: bloc,
    ))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: AppDimens.padding_2x,
              bottom: AppDimens.padding,
              right: AppDimens.padding_2x,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppDimens.padding_2x),
              child: Image.network(
                item.imageLink,
                height: 150.0,
                width: 150.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            item.name,
            style: AppStyles.bodyStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          // Visibility(
          //   visible: quantityVisible,
          //   child: Text(
          //     "$quantity items",
          //     style: AppStyles.bodyStyle,
          //   ),
          // ),
          Text(
            "${item.price}RON / item",
            style: AppStyles.bodyStyle,
          )
        ],
      ),
    );
  }
}
