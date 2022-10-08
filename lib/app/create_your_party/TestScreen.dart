import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lets_party/app/create_your_party/components/create_party_bloc.dart';

class TestScreen extends StatelessWidget {

  CreatePartyBloc bloc;


  TestScreen({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(
        image: FileImage(
          File(bloc.imageFile!)
        ),
      ),
    );
  }
}
