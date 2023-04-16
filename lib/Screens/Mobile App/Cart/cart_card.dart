import 'package:flutter/material.dart';
import '../../../Functions/addToCart.dart';
import '../Widgets/drop_button.dart';
import '../Dashboard/item_detail.dart';
import 'cart_detail.dart';

class cart_card extends StatefulWidget {
  final Map data;
  final Map UserData;

  const cart_card({
    Key? key,
    required this.data,
    required this.UserData,
  }) : super(key: key);

  @override
  State<cart_card> createState() => _cart_cardState();
}

class _cart_cardState extends State<cart_card> {
  bool _disable = false;
  // bool like = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => cart_detail(
                      data: widget.data,
                      UserData: widget.UserData,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          color: Colors.grey[200],
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Stack(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                          width: 190.00,
                          height: 120.00,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            image: _disable
                                ? const DecorationImage(
                                    image: AssetImage("logo"),
                                    fit: BoxFit.fill,
                                  )
                                : DecorationImage(
                                    image:
                                        NetworkImage('${widget.data["url"]}'),
                                    fit: BoxFit.fill,
                                  ),
                          )),

                    ],
                  ),
                  SizedBox(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '${widget.data["title"]}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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
              widget.data["UID"] == widget.UserData["UID"]
                  ? Positioned(
                      right: -7,
                      bottom: -5,
                      child: drop_button(
                          Coll: "products",
                          Doc: widget.data["Key"],
                          disable: !_disable))
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
