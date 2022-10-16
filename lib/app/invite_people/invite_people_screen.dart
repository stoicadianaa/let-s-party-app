import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lets_party/app/create_your_party/components/create_party_bloc.dart';
import 'package:lets_party/app/invite_people/components/user_placeholder.dart';
import 'package:lets_party/app/what_is_needed/what_is_needed_screen.dart';
import 'package:lets_party/constants/app_colors.dart';
import 'package:lets_party/constants/app_dimens.dart';
import 'package:lets_party/core/model/user_model.dart';
import 'package:lets_party/core/service/realtime_database_service.dart';
import 'package:lets_party/gen/fonts.gen.dart';

class InvitePeopleScreen extends StatelessWidget {
  CreatePartyBloc createPartyBloc;
  List<UserModel> listOfInvitedUsers = [];

  InvitePeopleScreen({required this.createPartyBloc});

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
        body: Column(
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
                horizontal: AppDimens.padding_2x,
              ),
              child: Column(
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          final snap = snapshot.data!.docs;
                          return SizedBox(
                            height: height*0.75,
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: snap.length,
                                itemBuilder: (context, index) {
                                  return Column(children: [
                                    user_placeholder(
                                      width: width,
                                      email: snap[index].id,
                                      name: snap[index]['name'] as String,
                                      onInvitePressed: () {
                                        listOfInvitedUsers.add(UserModel.allFields(
                                            snap[index]["name"] as String,
                                            snap[index].id,
                                            snap[index]["birthday"] as String));
                                      },
                                    ),
                                    const SizedBox(
                                      height: AppDimens.padding_2x,
                                    )
                                  ]);
                                }),
                          );
                        } else {
                          return SizedBox();
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(AppDimens.padding_2x),
          child: ElevatedButton(
            onPressed: () {
              createPartyBloc.invitedPeople = listOfInvitedUsers;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WhatIsNeeded(createPartyBloc: createPartyBloc)
              ));
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
              "Next: What is needed",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
