import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lets_party/constants/app_colors.dart';
import 'package:lets_party/constants/app_dimens.dart';
class PageButton extends StatelessWidget {
  late VoidCallback onPressed;
  late String svgAssetPath;
  late String text;

  PageButton(
      {required this.onPressed,
        required this.svgAssetPath,
        required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
              shape: MaterialStateProperty.all(const CircleBorder()),
              shadowColor: MaterialStateProperty.all(Colors.grey),
              backgroundColor: MaterialStateProperty.all(gamboge)),
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.padding_2x),
            child: SvgPicture.asset(
              svgAssetPath,
              width: 30.0,
              height: 30.0,
            ),
          ), //shape: CircleBorder(),
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12.5,
          ),
        )
      ],
    );
  }
}