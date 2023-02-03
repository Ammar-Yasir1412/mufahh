import 'package:flutter/material.dart';
import '../../../Widgets/drop_button.dart';
import '../../Dashboard/item_detail.dart';

class favourite_card extends StatefulWidget {
  final Map data;
  final Map UserData;

  const favourite_card({
    Key? key,
    required this.data,
    required this.UserData,
  }) : super(key: key);

  @override
  State<favourite_card> createState() => _favourite_cardState();
}

class _favourite_cardState extends State<favourite_card> {
  bool _disable = false;
  bool like = false;

  @override
  Widget build(BuildContext context) {
    var Likes = widget.data["Likes"];
    if (Likes != null) {
      for (var entry in Likes.entries) {
        if (widget.data["UID"] == entry.value) {
          setState(() {
            like = true;
          });
        }
      }
    }
    return InkWell(
      onTap: () {
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
                  Container(
                      width: 190.00,
                      height: 120.00,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        image: _disable
                            ? DecorationImage(
                                image: AssetImage("logo"),
                                fit: BoxFit.fill,
                              )
                            : DecorationImage(
                                image: NetworkImage('${widget.data["url"]}'),
                                fit: BoxFit.fill,
                              ),
                      )),
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