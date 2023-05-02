import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../Functions/addToCart.dart';
import '../Widgets/dateConverte.dart';
import 'item_detail.dart';

class item_card extends StatefulWidget {
  final Map data;
  final Map UserData;

  const item_card({
    Key? key,
    required this.data,
    required this.UserData,
  }) : super(key: key);

  @override
  State<item_card> createState() => _item_cardState();
}

class _item_cardState extends State<item_card> {
  bool _disable = false;
  bool like = false;

  @override
  Widget build(BuildContext context) {
    // widget.itemdata["disable"] != null ? _disable = widget.itemdata["disable"] : null;
    var Likes = widget.data["Likes"];
    if (Likes != null) {
      // TotelLikes = Likes.length;
      // print('===========Length=============>${Likes.length}');
      for (var entry in Likes.entries) {
        if (widget.UserData["UID"] == entry.value) {
          setState(() {
            like = true;
          });
        }
        // print('===========Like or unlike=============>${Like}');
      }
    }
    var now = DateTime.now().microsecondsSinceEpoch;
    print(now.toString());
    return InkWell(
      onTap: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => item_detail(
                      data: widget.data,
                      UserData: widget.UserData,
                    )));
        if (now > widget.data["bidStart"]) {
          FirebaseFirestore firestore = FirebaseFirestore.instance;
          await firestore
              .collection("products")
              .doc(widget.data["Key"])
              .update({"Live": widget.data["Live"] + 1});
        }
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Stack(
            children: [
              Row(
                children: [
                  Container(
                      width: 120.00,
                      height: 100.00,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        image: _disable
                            ? const DecorationImage(
                                image: AssetImage("logo"),
                                fit: BoxFit.fill,
                              )
                            : DecorationImage(
                                image: NetworkImage('${widget.data["url"]}'),
                                fit: BoxFit.fill,
                              ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '${widget.data["title"]}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        Text(
                          "Price \$${widget.data["price"]}",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.data["bidStart"] > now ||
                                  widget.data["bidStart"] > now
                              ? "Live After: ${dateConverte(widget.data["bidStart"], "Left")}"
                              : "Live Now: ${dateConverte(widget.data["bidEnd"], "Left")}",
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                        ),

                        // Text(
                        //   '${widget.data["category"]}',                          overflow: TextOverflow.ellipsis,
                        //
                        //   style: TextStyle(color: Colors.black),
                        // ),
                        // Text(
                        //   "${widget.data["description"]}",
                        //   overflow: TextOverflow.ellipsis,
                        //
                        //   style: TextStyle(color: Colors.black),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    now > widget.data["bidStart"]
                        ? Container(
                            color: Colors.red,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Row(
                                children: [
                                  const Text(
                                    "Live",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 3),
                                  const Icon(
                                    Icons.visibility,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    "${widget.data["Live"]}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(),
                    InkWell(
                      onTap: () {
                        if (like == false) {
                          addToCart(widget.data["Key"], widget.data["Likes"],
                              widget.UserData);
                        } else {
                          UnaddToCart(widget.data["Key"], widget.data["Likes"],
                              widget.UserData);
                          setState(() {
                            like = false;
                          });
                        }
                      },
                      child: Icon(
                        like ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
