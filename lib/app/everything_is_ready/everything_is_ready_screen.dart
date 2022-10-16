import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lets_party/app/create_your_party/components/create_party_bloc.dart';
import 'package:lets_party/constants/app_colors.dart';
import 'package:lets_party/constants/app_dimens.dart';
import 'package:lets_party/gen/fonts.gen.dart';

class EverythingIsReadyScreen extends StatelessWidget {
  final CreatePartyBloc createPartyBloc;

  const EverythingIsReadyScreen({required this.createPartyBloc});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        leadingWidth: 100.0,
        toolbarHeight: 100.0,
        title: Text(
          "${createPartyBloc.partyModel.name}",
          style: const TextStyle(
            color: jet,
            fontSize: 42.0,
            fontFamily: FontFamily.keepOnTrucking,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.16,
          ),
          Row(
            children: [
              Expanded(
                  child: SvgPicture.asset("assets/images/party_people.svg")),
            ],
          ),
          const Text(
            "Everything is ready",
            style: TextStyle(
              color: jet,
              fontSize: 30.0,
              fontFamily: FontFamily.keepOnTrucking,
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(AppDimens.padding_2x),
        child: ElevatedButton(
          onPressed: () {

            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
          },
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(
              Size(
                MediaQuery.of(context).size.width,
                55,
              ),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
          ),
          child: const Text(
            "Go back to home screen",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    ));
  }
}
