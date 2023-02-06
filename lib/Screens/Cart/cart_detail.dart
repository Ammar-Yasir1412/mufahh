import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Functions/toast.dart';
import '../../Widgets/myLargeButton.dart';
import '../../Widgets/myTextField.dart';

class cart_detail extends StatefulWidget {
  final Map data;
  final Map UserData;

  const cart_detail({Key? key, required this.data, required this.UserData})
      : super(key: key);

  @override
  State<cart_detail> createState() => _cart_detailState();
}

class _cart_detailState extends State<cart_detail> {
  bool looding = false;
  TextEditingController amountCTRL = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  addBid() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Add Your Bid"),
        content: myTextField(
          context,
          "Enter your Amount",
          Icons.person,
          amountCTRL,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              bidNow();
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child: const Text("Confirm"),
            ),
          ),
        ],
      ),
    );
  }

  bidNow() async {
    setState(() {
      looding = true;
    });
    var amount = amountCTRL.text;

    try {
      if (amount != '') {
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('EEE d MMM').format(now);
        var data = widget.data['Bid'] ?? [];
        data.add({
          "UID": widget.UserData["UID"],
          "amount": amount,
          "address": widget.UserData["address"],
          "username": widget.UserData["username"],
          "email": widget.UserData["email"],
          "PhoneNo": widget.UserData["PhoneNo"],
          "JoinDate": formattedDate,
        });
        await firestore
            .collection("products")
            .doc(widget.data["Key"])
            .update({"Bid": data});
        toast("Bid Uploaded");
      } else {
        toast("Please fill all text field");
      }
    } catch (e) {
      print(e);
      toast(e.toString());
    }
    setState(() {
      looding = false;
    });
  }

  closeBid() async {
    setState(() {
      looding = true;
    });
    var bidData = widget.data['Bid'];
    var bidWiner = bidData[0];
    try {
      var largervalue = 0;
      for (int i = 0; i < bidData.length; i++) {
        if (int.parse(bidData[i]["amount"]) > largervalue) {
          largervalue = int.parse(bidData[i]["amount"]);
          bidWiner = bidData[i];
        }
      }
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('EEE d MMM').format(now);
      await firestore
          .collection("products")
          .doc(widget.data["Key"])
          .update({"bidClose": true, "winner": bidWiner["UID"]});
      await firestore.collection("notification").doc().set({
        "title":
        "Congratulation ${bidWiner["username"]} you are won the ${widget.data["title"]}. Contact the owner and get the product.",
        "UID": bidWiner["UID"],
        "JoinDate": formattedDate,
      });
      toast("Bid Complete");
      Navigator.pop(context);
    } catch (e) {
      toast(e.toString());
    }
    setState(() {
      looding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var vwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                (Color.fromARGB(255, 99, 4, 4)),
                (Color.fromARGB(255, 99, 4, 4)),
                (Color.fromARGB(255, 223, 24, 17))
              ],
            ),
          ),
        ),
        title: Text(
          "Detail",
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network("${widget.data["url"]}"),
            Padding(
              padding: const EdgeInsets.only(left: 22.0, right: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.data["title"]}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Text(
                          // "Last Bid: ${widget.data["lastBid"]}",
                          "Post Now: ${widget.data["JoinDate"]}",
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                  _spacer(),
                  Text(
                    "Type: ${widget.data["category"]}",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  _spacer(),
                  Text(
                    "Description: ${widget.data["description"]}",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  _spacer(),
                  Text(
                    "Address: ${widget.data["address"]}",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  _spacer(),
                  widget.data['Bid'] != null
                      ? Column(
                    children: [
                      Center(
                        child: Text(
                          "Biddings ",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.data['Bid'].length,
                          itemBuilder: (BuildContext context, int index) {
                            var _data = widget.data['Bid'][index];
                            return Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                _text(_data['username']),
                                _text(_data['amount']),
                              ],
                            );
                          }),
                    ],
                  )
                      : Container(),
                  _spacer(),
                  Center(
                      child: widget.data["UID"] == widget.UserData["UID"]
                          ? myLargeButton(
                          context, "Close Bid", closeBid, looding)
                          : myLargeButton(context, "Bid Now", addBid, looding)),
                ],
              ),
            ),
            _spacer(),
          ],
        ),
      ),
    );
  }
}

Widget _spacer() {
  return const SizedBox(
    height: 10,
    width: 10,
  );
}

Widget _text(text) {
  return SizedBox(
    width: 150,
    child: Text(
      text,
      style: const TextStyle(fontSize: 18),
    ),
  );
}