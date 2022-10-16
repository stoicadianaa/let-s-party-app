import 'package:flutter/material.dart';
import 'package:lets_party/app/mixins/string_mixins.dart';
import 'package:lets_party/constants/app_dimens.dart';
import 'package:lets_party/constants/app_styles.dart';
import 'package:lets_party/core/model/party_model.dart';

import '../../constants/app_colors.dart';

class PartyDescription extends StatelessWidget with StringMixins {
  final PartyModel party;
  final String hostName;

  PartyDescription(this.party, this.hostName);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(AppDimens.roundedCorners),
            child: Image.network(party.pictureLink ?? "https://www.macmillandictionary.com/external/slideshow/thumb/Grey_thumb.png"),
        ),
        const SizedBox(height: AppDimens.padding_2x,),
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: Text(
            party.hostEmail == null ? "Unknown host" : "Party hosted by $hostName",
            textAlign: TextAlign.center,
            style: AppStyles.bodyStyle,
          ),
        ),
        const SizedBox(height: AppDimens.padding_2x,),
        Container(
          height: 30.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: party.tags == null ? 0 : party.tags!.length,
            itemBuilder: (context, count) {
              return Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(party.tags![count], style: AppStyles.bodyStyle,),
                    style: ButtonStyle(
                      // fixedSize: MaterialStateProperty.all(Size())
                      elevation: MaterialStateProperty.all(0.0),
                      enableFeedback: false,
                    ),
                  ),
                  SizedBox(width: AppDimens.padding,),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: AppDimens.padding_3x,),
        Text("Description", style: AppStyles.bodyStyle.copyWith(fontWeight: FontWeight.bold),),
        const SizedBox(height: AppDimens.padding,),
        Text(party.description ?? "Empty description", style: AppStyles.bodyStyle,),
        const SizedBox(height: AppDimens.padding_3x,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("When", style: AppStyles.bodyStyle.copyWith(fontWeight: FontWeight.bold),),
                  const SizedBox(height: AppDimens.padding_2x,),
                  Text(party.when != null ? formatDate(party.when!) : " No date yet", style: AppStyles.bodyStyle,),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Where", style: AppStyles.bodyStyle.copyWith(fontWeight: FontWeight.bold),),
                  const SizedBox(height: AppDimens.padding_2x,),
                  Text(party.where ?? "Empty location", style: AppStyles.bodyStyle,),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
