import 'package:flutter/material.dart';
import 'package:lets_party/app/create_your_party/create_party_screen.dart';
import 'package:lets_party/app/home/components/page_button.dart';
import 'package:lets_party/core/service/realtime_database_service.dart';
class HomeMenu extends StatelessWidget {
  RealtimeDatabaseService realtimeDatabaseService = new RealtimeDatabaseService();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          PageButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => CreatePartyScreen(),
                  ),
                );
              },
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
      ),
    );
  }
}