import 'package:flutter/material.dart';
import '../../../Functions/addToCart.dart';
import '../Widgets/drop_button.dart';
import '../Dashboard/item_detail.dart';

class simple_card extends StatefulWidget {
  final Map data;
  final Map UserData;

  const simple_card({
    Key? key,
    required this.data,
    required this.UserData,
  }) : super(key: key);

  @override
  State<simple_card> createState() => _simple_cardState();
}

class _simple_cardState extends State<simple_card> {
  bool _disable = false;
  // bool like = false;

  @override
  Widget build(BuildContext context) {
    // widget.itemdata["disable"] != null ? _disable = widget.itemdata["disable"] : null;
    // var Likes = widget.data["Likes"];
    // if (Likes != null) {
    //   // TotelLikes = Likes.length;
    //   // print('===========Length=============>${Likes.length}');
    //   for (var entry in Likes.entries) {
    //     if (widget.data["UID"] == entry.value) {
    //       setState(() {
    //         like = true;
    //       });
    //     }
    //     // print('===========Like or unlike=============>${Like}');
    //   }
    // }
    return InkWell(
      onTap: () {
        // _disable
        //     ?
        // snackbar("Sorry This is unavailable at this time"):
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => item_detail(
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
