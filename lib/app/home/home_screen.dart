import 'package:flutter/material.dart';
import 'package:lets_party/app/home/components/home_menu.dart';
import 'package:lets_party/app/home/components/party_button.dart';
import 'package:lets_party/app/home/home_screen_bloc.dart';
import 'package:lets_party/app/party_host/party_host_screen.dart';
import 'package:lets_party/app/party_invited/party_invited_screen.dart';
import 'package:lets_party/constants/app_colors.dart';
import 'package:lets_party/constants/app_dimens.dart';
import 'package:lets_party/core/model/party_model.dart';
import 'package:lets_party/gen/fonts.gen.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final listOfHostedParties = _databaseService.
    return ChangeNotifierProvider(
      create: (context) => HomeScreenBloc(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0.0,
            leadingWidth: 100.0,
            toolbarHeight: 80.0,
            /*leading: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Back",
                style: TextStyle(
                  color: gamboge,
                  fontSize: 20.0,
                ),
              ),
            ),*/
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
              horizontal: AppDimens.padding_2x,
              vertical: AppDimens.padding_2x,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeMenu(),
                  Consumer<HomeScreenBloc>(
                    builder: (context, homeScreenBloc, child) {
                      if (homeScreenBloc.listOfParties.isEmpty) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(AppDimens.padding_2x),
                            child: LinearProgressIndicator(),
                          ),
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(
                                AppDimens.padding,
                                AppDimens.padding_3x,
                                AppDimens.padding,
                                AppDimens.padding_2x,
                              ),
                              child: Text(
                                "next parties",
                                style: TextStyle(
                                  fontFamily: FontFamily.keepOnTrucking,
                                  fontSize: 35.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 175,
                              child: ListView.builder(
                                itemCount: homeScreenBloc.goingParties.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final PartyModel party = homeScreenBloc.goingParties[index];
                                  return PartyButton(
                                    image: party.pictureLink!,
                                    name: party.name!,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              PartyInvited(party.id!),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(
                                AppDimens.padding,
                                AppDimens.padding_3x,
                                AppDimens.padding,
                                AppDimens.padding_2x,
                              ),
                              child: Text(
                                "hosting",
                                style: TextStyle(
                                  fontFamily: FontFamily.keepOnTrucking,
                                  fontSize: 35.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 175,
                              child: ListView.builder(
                                itemCount: (homeScreenBloc
                                        .listOfParties['hosted'] as List)
                                    .length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final PartyModel party =
                                      homeScreenBloc.listOfParties['hosted']
                                          [index] as PartyModel;
                                  return PartyButton(
                                    image: party.pictureLink!,
                                    name: party.name!,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              PartyHost(party.id!),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
