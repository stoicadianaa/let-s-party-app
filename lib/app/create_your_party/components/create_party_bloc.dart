import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_party/core/model/party_model.dart';
import 'package:lets_party/core/model/user_model.dart';
import 'package:lets_party/core/service/firebase_auth_service.dart';
import 'package:lets_party/core/service/realtime_database_service.dart';



class CreatePartyBloc extends ChangeNotifier {
  PartyModel partyModel = PartyModel(null, null, null, null, null, null, null, null);
  String? imageFile;
  Map<String, int> whatIsNeeded = Map();
  List<UserModel> invitedPeople = [];
  String tags = "";

  static String getDateFormatted(DateTime date) =>
      "${date.year.toString()}-${date.month.toString()}-${date.day.toString()}";

  Future<void> pickDate(BuildContext context) async {
    DateTime? date;
    date = await showDatePicker(
      context: context,
      initialDate: DateTime.utc(DateTime.now().year),
      firstDate: DateTime.utc(DateTime.now().year),
      lastDate: DateTime.utc(DateTime.now().year + 2),
    );
    if(date != null) {
      partyModel.when = date;
    }
    notifyListeners();
  }

  Future<void> pickRsvpDate(BuildContext context) async {
    DateTime? date;
    date = await showDatePicker(
      context: context,
      initialDate: DateTime.utc(DateTime.now().year),
      firstDate: DateTime.utc(DateTime.now().year),
      lastDate: DateTime.utc(DateTime.now().year + 2),
    );
    if(date != null) {
      partyModel.rsvp = date;
    }
    notifyListeners();
  }

}
