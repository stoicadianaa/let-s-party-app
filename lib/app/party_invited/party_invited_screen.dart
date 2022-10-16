import 'package:flutter/material.dart';
import 'package:lets_party/app/components/party_description.dart';
import 'package:lets_party/app/mixins/string_mixins.dart';
import 'package:lets_party/app/party_invited/party_invited_bloc.dart';
import 'package:lets_party/constants/app_dimens.dart';
import 'package:lets_party/constants/app_styles.dart';
import 'package:provider/provider.dart';

class PartyInvited extends StatelessWidget with StringMixins {
  String partyID;

  PartyInvited(this.partyID);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PartyInvitedBloc(partyID),
      child: Consumer<PartyInvitedBloc>(
        builder: (context, partyBloc, child) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  partyBloc.party != null ? partyBloc.party!.name! : "",
                  style: AppStyles.appBarStyle,
                ),
                leading: TextButton(
                  child: const Text("Back", style: AppStyles.bodyStyle,),
                  onPressed: () => Navigator.pop(context),
                ),
                leadingWidth: 80.0,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.padding_2x,
                ),
                child: partyBloc.party != null
                    ? SizedBox(
                        height: double.infinity,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              PartyDescription(partyBloc.party!, partyBloc.hostName ?? "Unknown host"),
                              const SizedBox(
                                height: AppDimens.padding_3x,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "RSVP: ${partyBloc.party!.rsvp != null ? formatDate(partyBloc.party!.rsvp!) : "No date set"}",
                                    style: AppStyles.bodyStyle
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: AppDimens.padding_2x),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // bloc.getHostName();
                                          },
                                          style: const ButtonStyle(
                                              // shape:
                                              ),
                                          child: const Text("I'll attend", style: AppStyles.bodyStyle,),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: AppDimens.padding_2x,
                                      ),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: const Text("I won't attend", style: AppStyles.bodyStyle,),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: AppDimens.padding,
                              ),
                            ],
                          ),
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
