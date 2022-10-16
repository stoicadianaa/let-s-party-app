import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lets_party/app/create_your_party/components/create_party_bloc.dart';
import 'package:lets_party/constants/app_colors.dart';
import 'package:lets_party/constants/app_dimens.dart';
import 'package:lets_party/constants/app_styles.dart';
import 'package:lets_party/core/model/item_model.dart';

class SelectItemCount extends StatefulWidget {
  final ItemModel itemModel;
  final String imageLink;
  final CreatePartyBloc createPartyBloc;

  SelectItemCount({
    required this.imageLink,
    required this.itemModel,
    required this.createPartyBloc,
  });

  @override
  _SelectItemCountState createState() => _SelectItemCountState();
}

class _SelectItemCountState extends State<SelectItemCount> {
  int itemCount = 0;
  double total = 0;
  bool buttonPressed = false;
  
  void updateTotal() {
    total = itemCount * widget.itemModel.price;
  }
  
  void setInitialItemCount() {
    if (!buttonPressed) {
      if (widget.createPartyBloc.whatIsNeeded[widget.itemModel.name] != null) {
        itemCount = widget.createPartyBloc.whatIsNeeded[widget.itemModel.name]!;
        total = itemCount * widget.itemModel.price;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    setInitialItemCount();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          widget.itemModel.name,
          style: AppStyles.appBarStyle.copyWith(color: Colors.white),
        ),
        leading: TextButton(
          child: const Text(
            "Back",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            width: width,
            height: height * 0.30,
            color: gamboge,
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.1,
                ),
                Container(
                  height: height * 0.25,
                  width: width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.0),
                    image: DecorationImage(
                      image: NetworkImage(widget.imageLink),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.1,
                )
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsets.fromLTRB(0.0, height * 0.05, 0.0, height * 0.01),
            child: Text(
              "How many items:",
              style: TextStyle(
                fontSize: width * 0.065,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, AppDimens.padding_2x),
            child: Text(
              "Price/unit: ${widget.itemModel.price} RON",
              style: TextStyle(
                fontSize: width * 0.038,
              ),
            ),
          ),
          Text(
            "Total: ${total.toStringAsFixed(2)} RON",
            style: TextStyle(
              fontSize: width * 0.038,
            ),
          ),
          SizedBox(
            height: height * 0.1,
          ),
          Row(
            children: [
              Expanded(child: SizedBox(width: 5,)),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.black12,
                      width: 5.0,
                    )),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (itemCount > 0) {
                              buttonPressed = true;
                              itemCount--;
                              updateTotal();
                            }
                          });
                        },
                        icon: Icon(Icons.remove))),
              ),
              Expanded(child: SizedBox(width: 5,)),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: AppDimens.padding_2x,
                      horizontal: 30),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.black12,
                    width: 5.0,
                  )),
                  child: Text(
                    "$itemCount",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(child: SizedBox(width: 5,)),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.black12,
                      width: 5.0,
                    )),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (itemCount < 200) {
                              buttonPressed = true;
                              itemCount++;
                              updateTotal();
                            }
                          });
                        },
                        icon: Icon(Icons.add))),
              ),
              Expanded(child: SizedBox(width: 5,)),
            ],
          )
        ],
      ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(AppDimens.padding_2x),
            child: ElevatedButton(
              onPressed: () {
                String name = widget.itemModel.name;
                if (itemCount > 0) {
                  widget.createPartyBloc.whatIsNeeded[name] = itemCount;
                } else if (widget.createPartyBloc.whatIsNeeded[name] != null){
                  widget.createPartyBloc.whatIsNeeded.remove(name);
                }
                Navigator.pop(context);
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
                "Set amount",
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
