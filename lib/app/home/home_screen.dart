import 'package:flutter/material.dart';
import 'package:lets_party/app/home/components/home_menu.dart';
import 'package:lets_party/app/home/components/party_button.dart';
import 'package:lets_party/constants/app_colors.dart';
import 'package:lets_party/constants/app_dimens.dart';
import 'package:lets_party/gen/fonts.gen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0.0,
          leadingWidth: 100.0,
          toolbarHeight: 80.0,
          leading: TextButton(
            onPressed: () {},
            child: const Text(
              "Back",
              style: TextStyle(
                color: gamboge,
                fontSize: 20.0,
              ),
            ),
          ),
          title: const Text(
            "let's party!",
            style: TextStyle(
              color: jet,
              fontSize: 42.0,
              fontFamily: FontFamily.keepOnTrucking,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.padding_2x, vertical: AppDimens.padding_2x),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeMenu(),
                const Padding(
                  padding: EdgeInsets.fromLTRB(
                      AppDimens.padding,
                      AppDimens.padding_3x,
                      AppDimens.padding,
                      AppDimens.padding),
                  child: Text(
                    "next parties",
                    style: TextStyle(
                      fontFamily: FontFamily.keepOnTrucking,
                      fontSize: 35.0,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      PartyButton(
                        image: "assets/images/party-picture-defaultv2.jpg",
                        name: "My Great party",
                        onPressed: () {},
                      ),
                      PartyButton(
                        image: "assets/images/party-picture-defaultv2.jpg",
                        name: "My Great party",
                        onPressed: () {},
                      ),
                      PartyButton(
                        image: "assets/images/party-picture-defaultv2.jpg",
                        name: "My Great party",
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(
                      AppDimens.padding,
                      AppDimens.padding_3x,
                      AppDimens.padding,
                      AppDimens.padding),
                  child: Text(
                    "hosting",
                    style: TextStyle(
                      fontFamily: FontFamily.keepOnTrucking,
                      fontSize: 35.0,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      PartyButton(
                        image: "assets/images/party-picture-defaultv2.jpg",
                        name: "My Great party",
                        onPressed: () {},
                      ),
                      PartyButton(
                        image: "assets/images/party-picture-defaultv2.jpg",
                        name: "My Great party",
                        onPressed: () {},
                      ),
                      PartyButton(
                        image: "assets/images/party-picture-defaultv2.jpg",
                        name: "My Great party",
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
