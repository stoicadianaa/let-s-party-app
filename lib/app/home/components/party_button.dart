import 'package:flutter/material.dart';
import 'package:lets_party/constants/app_dimens.dart';
class PartyButton extends StatelessWidget {
  String image;
  String name;
  VoidCallback onPressed;

  PartyButton(
      {required this.image, required this.name, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.padding),
      child: RawMaterialButton(
        onPressed: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Stack(
                  children: [
                    Container(
                      width: 200,
                      height: 130,
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimens.padding),
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}