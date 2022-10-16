import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lets_party/app/components/category_widget.dart';
import 'package:lets_party/app/create_your_party/components/create_party_bloc.dart';
import 'package:lets_party/app/everything_is_ready/everything_is_ready_screen.dart';

import 'package:lets_party/app/items_page/items_page_bloc.dart';
import 'package:lets_party/constants/app_dimens.dart';
import 'package:lets_party/constants/app_styles.dart';
import 'package:lets_party/core/model/user_model.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../gen/fonts.gen.dart';

class WhatIsNeeded extends StatefulWidget {

  final CreatePartyBloc createPartyBloc;

  WhatIsNeeded({required this.createPartyBloc});

  @override
  State<WhatIsNeeded> createState() => _WhatIsNeededState();
}

class _WhatIsNeededState extends State<WhatIsNeeded> {
  late ItemsPageBloc bloc;

  @override
  void initState() {
    bloc = ItemsPageBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => bloc,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0.0,
            leadingWidth: 80.0,
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
              "what's needed",
              style: TextStyle(
                color: jet,
                fontSize: 42.0,
                fontFamily: FontFamily.keepOnTrucking,
              ),
            ),
            centerTitle: true,
          ),
          body: Consumer<ItemsPageBloc>(
            builder: (context, itemsBloc, child) {
              if (!bloc.loadingDone) {
                return const Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding: EdgeInsets.all(AppDimens.padding_2x),
                child: ListView.builder(
                  itemCount: bloc.listOfCategories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CategoryWidget(category: bloc.listOfCategories[index], enableItemSelect: true, createPartyBloc: widget.createPartyBloc,);
                  },
                ),
              );
            },
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(AppDimens.padding_2x),
            child: ElevatedButton(
              onPressed: () async {
                for (String i in widget.createPartyBloc.whatIsNeeded.keys) {
                  print(i);
                  print(widget.createPartyBloc.whatIsNeeded[i]);
                }
                Map<String, dynamic> createPartyRequest = Map<String, dynamic>();
                createPartyRequest["name"] = widget.createPartyBloc.partyModel.name;
                createPartyRequest["description"] = widget.createPartyBloc.partyModel.description;
                createPartyRequest["hostEmail"] = FirebaseAuth.instance.currentUser != null ? FirebaseAuth.instance.currentUser!.email : "somebody@mail.com";
                Map<String, String> invitedPeople = Map();
                for (var userModel in widget.createPartyBloc.invitedPeople) {
                  invitedPeople[userModel.email!] = "invited";
                }
                createPartyRequest["guests"] = invitedPeople;
                String? imagePath = widget.createPartyBloc.imageFile;

                final storageRef = FirebaseStorage.instance.ref();
                final partyImageRef = storageRef.child("party_image/${widget.createPartyBloc.partyModel.name}");

                if (imagePath != null) {
                  String url = await uploadFile(imagePath, partyImageRef);
                  createPartyRequest["pictureLink"] = url;
                }

                createPartyRequest["rsvp"] = widget.createPartyBloc.partyModel.rsvp.toString();
                createPartyRequest["tags"] = widget.createPartyBloc.tags;
                createPartyRequest["when"] = widget.createPartyBloc.partyModel.when.toString();
                createPartyRequest["where"] = widget.createPartyBloc.partyModel.where;
                createPartyRequest["needed"] = widget.createPartyBloc.whatIsNeeded;

                FirebaseFirestore.instance.collection("parties").add(createPartyRequest);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EverythingIsReadyScreen(createPartyBloc: widget.createPartyBloc,)
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
                "Finish your party",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        ),
        ),
    );
  }

  Future<String> uploadFile(String imagePath, Reference partyImageRef) async {
    File image = File(imagePath);
    await partyImageRef.putFile(image);
    String url = await partyImageRef.getDownloadURL();
    return url;
  }
}
