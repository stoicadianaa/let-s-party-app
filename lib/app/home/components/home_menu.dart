import 'package:flutter/material.dart';
import 'package:lets_party/app/home/components/page_button.dart';
class HomeMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PageButton(
            onPressed: () {},
            svgAssetPath: "assets/images/create_party.svg",
            text: "create party"),
        PageButton(
            onPressed: () {},
            svgAssetPath: "assets/images/my-invites.svg",
            text: "my invites"),
        PageButton(
            onPressed: () {},
            svgAssetPath: "assets/images/party-games.svg",
            text: "party games"),
        PageButton(
            onPressed: () {},
            svgAssetPath: "assets/images/settings.svg",
            text: "settings"),
      ],
    );
  }
}