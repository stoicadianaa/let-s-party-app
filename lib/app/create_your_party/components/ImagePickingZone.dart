import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lets_party/constants/app_dimens.dart';

class ImagePickingZone extends StatefulWidget {
  const ImagePickingZone({Key? key}) : super(key: key);



  @override
  _ImagePickingZoneState createState() => _ImagePickingZoneState();
}

class _ImagePickingZoneState extends State<ImagePickingZone> {

  File? image;
  bool? isImagedPicked = false;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if(image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
      this.isImagedPicked = true;
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  /// Used to get image from camera
  Future pickImageFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if(image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: AppDimens.padding_2x),
      child: SizedBox(
        height: MediaQuery.of(context).size.height*0.25,
        width: MediaQuery.of(context).size.width,
        child: TextButton(
          onPressed: () {
            pickImage();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.grey.shade400),
            shape:  MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                )
            ),
          ),

          child: Text(
            "add photo",
            style: TextStyle(
              fontSize: 30,
              color: Colors.grey.shade700,
            ),
          ),
        ),
      ),
    );
  }
}
