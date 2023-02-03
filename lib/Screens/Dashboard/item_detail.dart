import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Functions/toast.dart';
import '../../constants/style.dart';

class item_detail extends StatefulWidget {
  final Map data;
  final Map UserData;

  const item_detail({Key? key, required this.data, required this.UserData}) : super(key: key);

  @override
  State<item_detail> createState() => _item_detailState();
}

class _item_detailState extends State<item_detail> {
  bool looding = false;
  TextEditingController amountCTRL = TextEditingController(text: "50000");

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  bidNow  () async {
    setState(() {
      looding = true;
    });
    var amount = amountCTRL.text;

    try {
      if (amount != '') {
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('EEE d MMM').format(now);
        var data = widget.data['Bid']??[];
        data.add({
          "UID": widget.UserData["UID"],
          "amount":amount,
          "address": widget.UserData["address"],
          "username": widget.UserData["username"],
          "email": widget.UserData["email"],
          "PhoneNo": widget.UserData["PhoneNo"],
          "JoinDate": formattedDate,
        });
        await firestore.collection("products").doc(widget.data["Key"]).update({
          "Bid": data
        });
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

  @override
  Widget build(BuildContext context) {
    var vwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
      // MyAppBar2(context, "Detail", true, () {}, false),
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
                  _spacer(),
                  Center(
                    child: InkWell(
                      onTap: (){
                        bidNow();
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: appBarColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(
                            top: 8.0,
                            right: 18.0,
                            left: 18.0,
                            bottom: 8.0,
                          ),
                          child: Text(
                            "Bid Now",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
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
  return SizedBox(
    height: 10,
    width: 10,
  );
}
