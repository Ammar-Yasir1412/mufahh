import 'package:flutter/material.dart';

import '../../Functions/addToCart.dart';
import '../../constants/style.dart';

class item_detail extends StatefulWidget {
  final Map data;
  final Map UserData;

  const item_detail({Key? key, required this.data, required this.UserData}) : super(key: key);

  @override
  State<item_detail> createState() => _item_detailState();
}

class _item_detailState extends State<item_detail> {
  var amount = 1;

  @override
  Widget build(BuildContext context) {

    // var number = widget.stalldata["PhoneNo"];
    // var totelprice = int.parse(widget.data["Price"]) * amount;
    // var text =
    //     " hi! ${widget.stalldata["stallname"]} I want to buy $amount ${widget.data["foodname"]} in $totelprice Rupees. in which time you will deliver";
    // Future<void> whatsappsms() async {
    //   final Uri _url = Uri.parse("whatsapp://send?phone=$number&text=$text");
    //   if (await canLaunchUrl(_url)) {
    //     await launchUrl(_url);
    //   } else {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //         const SnackBar(content: Text("Whatsapp not installed")));
    //   }
    // }
    //
    // Future<void> simsms() async {
    //   final Uri _url = Uri.parse("sms:$number?body=$text");
    //   if (await canLaunchUrl(_url)) {
    //     await launchUrl(_url);
    //   }
    // }
    //
    // Future<void> call() async {
    //   final Uri _url = Uri.parse("tel:$number");
    //   if (await canLaunchUrl(_url)) {
    //     await launchUrl(_url);
    //   }
    // }

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
                        style: TextStyle(
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
                ],
              ),
            ),
            _spacer(),
            _spacer()
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
