import 'package:flutter/material.dart';
import 'package:lets_party/app/create_your_party/components/create_party_bloc.dart';
import 'package:lets_party/app/invite_people/components/UserPlaceHolder.dart';
import 'package:lets_party/constants/app_colors.dart';
import 'package:lets_party/constants/app_dimens.dart';
import 'package:lets_party/gen/fonts.gen.dart';

class InvitePeopleScreen extends StatelessWidget {
  CreatePartyBloc createPartyBloc;

  InvitePeopleScreen({required this.createPartyBloc});

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
          toolbarHeight: 80.0,
          leading: TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Back",
              style: TextStyle(
                color: gamboge,
                fontSize: 20.0,
              ),
            ),
          ),
          title: const Text(
            "invite people",
            style: TextStyle(
              color: jet,
              fontSize: 42.0,
              fontFamily: FontFamily.keepOnTrucking,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                child: Text(
                  "total invited: 5",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: AppDimens.padding_2x,
                    horizontal: AppDimens.padding_2x),
                child: Column(
                  children: [
                    UserPlaceholder(width: width),
                    SizedBox(height: AppDimens.padding_2x),
                    UserPlaceholder(width: width),
                    SizedBox(height: AppDimens.padding_2x),

                    UserPlaceholder(width: width),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


