import 'package:flutter/material.dart';
import 'package:lets_party/app/party_atendee/needed_items/needed_items_bloc.dart';
import 'package:lets_party/app/party_atendee/needed_items/needed_items_screen.dart';
import 'package:lets_party/constants/app_colors.dart';
import 'package:lets_party/constants/app_dimens.dart';
import 'package:lets_party/constants/app_styles.dart';
import 'package:lets_party/core/model/item_model.dart';
import 'package:lets_party/core/service/realtime_database_service.dart';

class ChooseQuantityScreen extends StatefulWidget {
  final ItemModel itemModel;
  final String partyID;
  final NeededItemsBloc bloc;
  const ChooseQuantityScreen(
      {required this.itemModel, required this.partyID, required this.bloc});

  @override
  _ChooseQuantityScreenState createState() => _ChooseQuantityScreenState();
}

class _ChooseQuantityScreenState extends State<ChooseQuantityScreen> {
  double total = 0;
  bool buttonPressed = false;
  int maxCount = 0;
  // void setInitialItemCount() {
  //   if (!buttonPressed) {
  //     if (widget.createPartyBloc.whatIsNeeded[widget.itemModel.name] != null) {
  //       itemCount = widget.createPartyBloc.whatIsNeeded[widget.itemModel.name]!;
  //       total = itemCount * widget.itemModel.price;
  //     }
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getMaxQuantity();
  }

  // void getMaxQuantity() async {
  //   maxCount = await RealtimeDatabaseService.getNeededQuantity(
  //       widget.itemModel.name, widget.partyID);
  //   print(maxCount);
  // }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    int itemCount = widget.bloc.listOfItemsToBring[widget.itemModel.name] ?? 0;
    total = itemCount * widget.itemModel.price;
    // setInitialItemCount();



    void updateTotal() {
      total = itemCount * widget.itemModel.price;
    }

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
                        image: NetworkImage(widget.itemModel.imageLink),
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
              padding: const EdgeInsets.fromLTRB(
                0.0,
                0.0,
                0.0,
                AppDimens.padding_2x,
              ),
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
            // Text(
            //   "Needed quantity: ${total.toStringAsFixed(2)} RON",
            //   style: TextStyle(
            //     fontSize: width * 0.038,
            //   ),
            // ),
            SizedBox(
              height: height * 0.1,
            ),
            Row(
              children: [
                const Expanded(
                  child: SizedBox(
                    width: 5,
                  ),
                ),
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                        width: 5.0,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () async {
                        if (itemCount > 0) {
                          setState(() {
                            {
                              buttonPressed = true;
                              itemCount--;
                              updateTotal();
                            }
                          });
                            await RealtimeDatabaseService().addItemToParty(
                                widget.bloc.listOfItemsToBring,
                                widget.itemModel.name,
                                widget.partyID,
                                -1);
                        }
                      },
                      icon: const Icon(Icons.remove),
                    ),
                  ),
                ),
                const Expanded(
                  child: SizedBox(
                    width: 5,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppDimens.padding_2x,
                      horizontal: 30,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                        width: 5.0,
                      ),
                    ),
                    child: Text(
                      "$itemCount",
                      style: const TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const Expanded(
                  child: SizedBox(
                    width: 5,
                  ),
                ),
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                        width: 5.0,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () async {
                        if (itemCount < 200) {
                          setState(() {
                            {
                              buttonPressed = true;
                              itemCount--;
                              updateTotal();
                            }
                          });
                          await RealtimeDatabaseService().addItemToParty(
                              widget.bloc.listOfItemsToBring,
                              widget.itemModel.name,
                              widget.partyID,
                              1);
                        }
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ),
                ),
                const Expanded(
                  child: SizedBox(
                    width: 5,
                  ),
                ),
              ],
            )
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(AppDimens.padding_2x),
          child: ElevatedButton(
            onPressed: () {
              // if (itemCount > 0) {
              //   widget.createPartyBloc.whatIsNeeded[name] = itemCount;
              // } else if (widget.createPartyBloc.whatIsNeeded[name] != null) {
              //   widget.createPartyBloc.whatIsNeeded.remove(name);
              // }
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
