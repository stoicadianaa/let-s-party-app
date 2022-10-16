import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lets_party/app/components/input_field_widget.dart';
import 'package:lets_party/app/create_your_party/TestScreen.dart';
import 'package:lets_party/app/create_your_party/components/ImagePickingZone.dart';
import 'package:lets_party/app/create_your_party/components/create_party_bloc.dart';
import 'package:lets_party/app/invite_people/invite_people_screen.dart';
import 'package:lets_party/app/signup/signup_screen.dart';
import 'package:lets_party/constants/app_colors.dart';
import 'package:lets_party/constants/app_dimens.dart';
import 'package:lets_party/gen/fonts.gen.dart';
import 'package:provider/provider.dart';

class CreatePartyScreen extends StatelessWidget {
  final bloc = CreatePartyBloc();
  final dateRegex = RegExp(r'(\d{4}-\d{2}-\d{2})');

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => bloc,
      child: SafeArea(
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
              "create party",
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
                  ImagePickingZone(bloc: bloc,),
                  const SizedBox(
                    height: AppDimens.padding_2x,
                  ),
                  const Text(
                    "Name",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    height: AppDimens.padding,
                  ),
                  InputField(
                    hintText: "Give your party a name",
                    onChanged: (val) {
                      bloc.partyModel.name = val;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: (description) {
                      if (description != null && description != '') {
                        return null;
                      }
                      return "Invalid description";
                    },
                  ),
                  const SizedBox(
                    height: AppDimens.padding_2x,
                  ),
                  const Text(
                    "How",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    height: AppDimens.padding,
                  ),
                  InputField(
                    hintText: "Create short description",
                    onChanged: (val) {
                      bloc.partyModel.description = val;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: (description) {
                      if (description != null && description != '') {
                        return null;
                      }
                      return "Invalid description";
                    },
                  ),
                  const SizedBox(
                    height: AppDimens.padding_2x,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "WHEN",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          Consumer<CreatePartyBloc>(
                            builder: (context, cpb, child) => ElevatedButton(
                              onPressed: () async {
                                await cpb.pickDate(context);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(gamboge.withOpacity(0.5)),
                              ),
                              child: Text(
                                cpb.partyModel.when != null
                                    ? "Birthday: ${CreatePartyBloc.getDateFormatted(cpb.partyModel.when!)}"
                                    : "Choose date",
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: AppDimens.padding_2x,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            "RSVP",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          Consumer<CreatePartyBloc>(
                            builder: (context, cpb, child) => ElevatedButton(
                              onPressed: () async {
                                await cpb.pickRsvpDate(context);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(gamboge.withOpacity(0.5)),
                              ),
                              child: Text(
                                cpb.partyModel.rsvp != null
                                    ? "Birthday: ${CreatePartyBloc.getDateFormatted(cpb.partyModel.rsvp!)}"
                                    : "Choose date",
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: AppDimens.padding_2x,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Text(
                    "Where",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    height: AppDimens.padding,
                  ),
                  InputField(
                    hintText: "Enter the party's location",
                    onChanged: (val) {
                      bloc.partyModel.where = val;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: (description) {
                      if (description != null && description != '') {
                        return null;
                      }
                      return "Invalid description";
                    },
                  ),
                  const SizedBox(
                    height: AppDimens.padding_2x,
                  ),
                  const Text(
                    "Create tags (optional)",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    height: AppDimens.padding,
                  ),
                  InputField(
                    hintText: "Separate tags with commas",
                    onChanged: (val) {
                      if (val != null) {
                        bloc.tags = val;
                      }
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: (description) {
                      if (description != null && description != '') {
                        return null;
                      }
                      return "Invalid description";
                    },
                  ),
                  const SizedBox(
                    height: AppDimens.padding_4x,
                  ),
                  const SizedBox(
                    height: AppDimens.padding_4x,
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(AppDimens.padding_2x),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => InvitePeopleScreen(createPartyBloc: bloc)));
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
              child: const Text("Next: Invite people", style: TextStyle(
                fontSize: 20,
              ),),
            ),
          ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }
}
