import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
              children: [
                HomeMenu(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PageButton(onPressed: (){}, svgAssetPath: "assets/images/create_party.svg" , text: "create party"),
        PageButton(onPressed: (){}, svgAssetPath: "assets/images/my-invites.svg" , text: "my invites"),
        PageButton(onPressed: (){}, svgAssetPath: "assets/images/party-games.svg" , text: "party games"),
        PageButton(onPressed: (){}, svgAssetPath: "assets/images/settings.svg" , text: "settings"),
      ],
    );
  }
}

class PageButton extends StatelessWidget {
  late VoidCallback onPressed;
  late String svgAssetPath;
  late String text;

  PageButton({required this.onPressed, required this.svgAssetPath, required this.text});

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
            padding: const EdgeInsets.all(15.0),
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
