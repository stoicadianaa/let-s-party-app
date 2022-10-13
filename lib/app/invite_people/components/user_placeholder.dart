import 'package:flutter/material.dart';

import 'package:lets_party/constants/app_colors.dart';
import 'package:lets_party/constants/app_dimens.dart';

class user_placeholder extends StatefulWidget {
  user_placeholder({
    Key? key,
    required this.width,
    required this.name,
  }) : super(key: key);

  final double width;
  final String name;

  @override
  State<user_placeholder> createState() => _user_placeholderState();
}

class _user_placeholderState extends State<user_placeholder> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: widget.width * 0.150,
          child: CircleAvatar(
            backgroundColor: gamboge,
            radius: widget.width * 0.065,
            child: CircleAvatar(
              radius: widget.width * 0.055,
              backgroundImage: NetworkImage(
                  'https://www.giantbomb.com/a/uploads/scale_medium/1/14876/3065098-7871971516-4rstn.jpg'),
            ),
          ),
        ),
        const SizedBox(
          width: AppDimens.padding_2x,
        ),
        SizedBox(
          width: widget.width * 0.45,
          child: Text(
            widget.name,
            style: TextStyle(fontSize: widget.width * 0.050),
          ),
        ),
        const SizedBox(
          width: AppDimens.padding_4x,
        ),
        Expanded(
          child: Center(
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  pressed = true;
                });
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
                side: MaterialStateProperty.all(const BorderSide(width: 3.0, color: gamboge, style: BorderStyle.solid)),
                backgroundColor: pressed ? MaterialStateProperty.all(gamboge) : MaterialStateProperty.all(Colors.white),
              ),
              child: Text(
                "Invite",
                style: TextStyle(
                    fontSize: widget.width * 0.045,
                    color: pressed ? Colors.white : gamboge
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}