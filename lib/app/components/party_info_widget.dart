//TODO: find a better name

import 'package:flutter/material.dart';
import 'package:lets_party/constants/app_dimens.dart';
import 'package:lets_party/core/model/guest_model.dart';

class PartyInfo extends StatelessWidget {
  const PartyInfo(this.guestsList);

  final List<GuestModel> guestsList;
  static const blankPictureURL =
      "https://www.macmillandictionary.com/us/external/slideshow/full/Grey_full.png";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: guestsList.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Column(
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(AppDimens.roundedCorners),
                    child: Image.network(
                      guestsList[index].imageLink ?? blankPictureURL,
                      height: 100.0,
                      width: 100.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                      width: 100.0,
                      child: Text(
                        guestsList[index].name,
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
              SizedBox(
                width: AppDimens.padding_2x,
              )
            ],
          );
        },
      ),
    );
  }
}
