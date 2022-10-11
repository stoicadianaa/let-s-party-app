import 'package:flutter/material.dart';
import 'package:lets_party/app/components/party_description.dart';
import 'package:lets_party/app/components/party_info_widget.dart';
import 'package:lets_party/app/party_host/party_host_bloc.dart';
import 'package:lets_party/constants/app_dimens.dart';
import 'package:lets_party/constants/app_styles.dart';
import 'package:provider/provider.dart';

class PartyHost extends StatelessWidget {
  String partyID;

  PartyHost(this.partyID);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (context) => PartyHostBloc(partyID),
        child: Consumer<PartyHostBloc>(
          builder: (context, bloc, child) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  bloc.party != null ? bloc.party!.name! : "",
                  style: AppStyles.appBarStyle,
                ),
                leading: TextButton(
                  child: const Text(
                    "Back",
                    style: AppStyles.bodyStyle,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                leadingWidth: 80.0,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              ),
              body: Padding(
                padding: const EdgeInsets.all(AppDimens.padding_2x),
                child: (bloc.party != null &&
                        bloc.hostName != null &&
                        bloc.partyGuests != null)
                    ? ListView(
                        children: [
                          PartyDescription(bloc.party!, bloc.hostName!),
                          const SizedBox(
                            height: AppDimens.padding_3x,
                          ),
                          const Divider(thickness: 1.5,),
                          /*ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                const Size(double.infinity, 50.0),
                              ),
                            ),
                            child: const Text(
                              "Invite more people",
                              style: AppStyles.bodyStyle,
                            ),
                          ),*/
                          buildGuestsInfo(bloc),
                          const SizedBox(height: AppDimens.padding_2x,),
                          ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                const Size(double.infinity, 50.0),
                              ),
                            ),
                            child: const Text(
                              "What is needed",
                              style: AppStyles.bodyStyle,
                            ),
                          ),
                        ],
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }

  Column buildGuestsInfo(PartyHostBloc bloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppDimens.padding_3x,
        ),
        const Text(
          "who is coming?",
          style: AppStyles.categorytyle,
        ),
        const SizedBox(
          height: AppDimens.padding_2x,
        ),
        PartyInfo(bloc.partyGuests!.coming),
        const Text(
          "waiting for RSVP",
          style: AppStyles.categorytyle,
        ),
        const SizedBox(
          height: AppDimens.padding_2x,
        ),
        PartyInfo(bloc.partyGuests!.invited),
        const Text(
          "won’t be able to come",
          style: AppStyles.categorytyle,
        ),
        const SizedBox(
          height: AppDimens.padding_2x,
        ),
        PartyInfo(bloc.partyGuests!.notComing),
      ],
    );
  }
}
