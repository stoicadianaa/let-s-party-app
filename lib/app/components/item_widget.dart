import 'package:flutter/material.dart';
import 'package:lets_party/app/create_your_party/components/create_party_bloc.dart';
import 'package:lets_party/app/what_is_needed/components/select_item_count.dart';
import 'package:lets_party/constants/app_dimens.dart';
import 'package:lets_party/constants/app_styles.dart';
import 'package:lets_party/core/model/item_model.dart';

class ItemWidget extends StatelessWidget {
  ItemWidget({
    super.key,
    required this.title,
    this.quantity,
    required this.price,
    this.imageLink =
        "https://i.pinimg.com/564x/a9/e5/e4/a9e5e4e32e3ab4d170d052d50ef1b616.jpg",
    this.quantityVisible = false,
    this.item,
    this.enableItemSelect,
  this.createPartyBloc,
  });

  final String title;
  final int? quantity;
  final double price;
  final bool? enableItemSelect;
  bool quantityVisible;
  String imageLink;
  final ItemModel? item;
  final CreatePartyBloc? createPartyBloc;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (enableItemSelect != null && enableItemSelect == true) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SelectItemCount(
                        imageLink: imageLink,
                        itemModel: item!,
                        createPartyBloc: createPartyBloc!,
                      )
              ));
        }
      },
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
                imageLink,
                height: 110.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            title,
            style: AppStyles.bodyStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          Visibility(
            visible: quantityVisible,
            child: Text(
              "$quantity items",
              style: AppStyles.bodyStyle,
            ),
          ),
          Text(
            "${price}RON / item",
            style: AppStyles.bodyStyle,
          )
        ],
      ),
    );
  }
}
