import 'package:flutter/material.dart';
import 'package:lets_party/app/party_atendee/components/list_of_items_widget.dart';
import 'package:lets_party/app/party_atendee/needed_items/needed_items_bloc.dart';
import 'package:lets_party/constants/app_dimens.dart';
import 'package:lets_party/constants/app_styles.dart';
import 'package:lets_party/core/service/realtime_database_service.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class NeededItemsScreen extends StatelessWidget {
  const NeededItemsScreen({required this.partyID});

  final String partyID;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NeededItemsBloc(partyID),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "what is needed".i18n(),
              style: AppStyles.appBarStyle,
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: TextButton(
              child: Text("Back".i18n()),
              onPressed: () {
                // RealtimeDatabaseService().getListOfNeededItems(partyID);
              },
            ),
          ),
          body: Consumer<NeededItemsBloc>(
            builder: (context, bloc, child) {
              if (!bloc.loadingDone) {
                return const Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding: const EdgeInsets.all(AppDimens.padding_2x),
                child: ListView.builder(
                  itemCount: bloc.listOfNeededItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Visibility(
                      child: ListOfItemsWidget(bloc.listOfNeededItems[index], bloc, partyID)
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
