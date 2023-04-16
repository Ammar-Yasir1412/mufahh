import 'package:flutter/material.dart';
import '../../../../Functions/addToCart.dart';
import '../../Widgets/drop_button.dart';
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
        margin: const EdgeInsets.only(left: 12.0, right: 12, top: 12),
        padding: const EdgeInsets.all(4.0),
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
              Row(
                children: [
                  Container(
                      width: 120.00,
                      height: 100.00,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: NetworkImage('${widget.data["url"]}'),
                          fit: BoxFit.fill,
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.data["title"]}',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${widget.data["category"]}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            "${widget.data["description"]}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 10,
                top: 10,
                child: InkWell(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
