import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mufahh/constants/style.dart';
import 'package:url_launcher/url_launcher.dart';

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

  @override
  Widget build(BuildContext context) {
    var number = widget.data["PhoneNo"];
    var text =
        "Dear ${widget.data["stallname"]}, we are grateful for your support in feeding those in need. Could we please request a donation of food to help us continue our mission of fighting hunger in the community? Thank you for your generosity";
    // " hi! ${widget.stalldata["stallname"]} I want to buy $amount ${widget.itemdata["foodname"]} in $totelprice Rupees. in which time you will deliver";
    Future<void> whatsappsms() async {
      final Uri _url = Uri.parse("whatsapp://send?phone=$number&text=$text");
      if (await canLaunchUrl(_url)) {
        await launchUrl(_url);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp not installed")));
      }
    }

    Future<void> simsms() async {
      final Uri _url = Uri.parse("sms:$number?body=$text");
      if (await canLaunchUrl(_url)) {
        await launchUrl(_url);
      }
    }

    Future<void> call() async {
      final Uri _url = Uri.parse("tel:$number");
      if (await canLaunchUrl(_url)) {
        await launchUrl(_url);
      }
    }

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
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            (Color.fromARGB(255, 99, 4, 4)),
                            (Color.fromARGB(255, 223, 24, 17))
                          ],
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(
                          top: 6.0,
                          right: 22.0,
                          left: 22.0,
                          bottom: 6.0,
                        ),
                        child: Text(
                          "Contact with",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  _spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: whatsappsms,
                          icon: Icon(
                            color: Colors.green,
                            Icons.whatsapp,
                            size: 40,
                          )),
                      IconButton(
                          onPressed: call,
                          color: Colors.blue,
                          icon: Icon(
                            Icons.phone,
                            size: 40,
                          )),
                      IconButton(
                          onPressed: simsms,
                          icon: Icon(
                            color: appBarColor,
                            Icons.message,
                            size: 40,
                          )),
                    ],
                  )
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
