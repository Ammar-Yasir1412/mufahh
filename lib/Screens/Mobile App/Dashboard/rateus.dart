import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../Functions/toast.dart';
import '../Widgets/myTextField.dart';

var looding = false;

class rateStar extends StatefulWidget {
  final Map postData;
  final Map userData;
  const rateStar({super.key, required this.postData, required this.userData});

  @override
  State<rateStar> createState() => _rateStarState();
}

class _rateStarState extends State<rateStar> {
  var rate = 0;
  var num = 0.0;
  @override
  Widget build(BuildContext context) {
    var ratedata = widget.postData['rate'] ?? [0];
    setState(() {
      var numt = ratedata.fold(0, (previous, current) => previous + current);
      num = numt / ratedata.length;
    });
    print("num======>${num}");
    rateUS(context, postData, userData) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Center(child: Text("Rate us")),
          content:
              StatefulBuilder(// You need this, notice the parameters below:
                  builder: (BuildContext context, StateSetter setState) {
            return Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      setState(() {
                        rate = 2;
                      });
                    },
                    child: Icon(rate >= 2 ? Icons.star : Icons.star_border,
                        color: Colors.amber)),
                InkWell(
                    onTap: () {
                      setState(() {
                        rate = 4;
                      });
                    },
                    child: Icon(rate >= 4 ? Icons.star : Icons.star_border,
                        color: Colors.amber)),
                InkWell(
                    onTap: () {
                      setState(() {
                        rate = 6;
                      });
                    },
                    child: Icon(rate >= 6 ? Icons.star : Icons.star_border,
                        color: Colors.amber)),
                InkWell(
                    onTap: () {
                      setState(() {
                        rate = 8;
                      });
                    },
                    child: Icon(rate >= 8 ? Icons.star : Icons.star_border,
                        color: Colors.amber)),
                InkWell(
                    onTap: () {
                      setState(() {
                        rate = 10;
                      });
                    },
                    child: Icon(rate >= 10 ? Icons.star : Icons.star_border,
                        color: Colors.amber)),
              ],
            );
          }),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                try {
                  var data = postData['rate'] ?? [];
                  data.add(rate);
                  await FirebaseFirestore.instance
                      .collection("products")
                      .doc(postData["Key"])
                      .update({"rate": data});
                  // toast("rate Uploaded");
                  setState(() {
                    rate = 0;
                  });
                  Navigator.pop(context);
                } catch (e) {
                  toast(e.toString());
                }
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

    return InkWell(
      onTap: () async {
      await  rateUS(context, widget.postData, widget.userData);
      setState(() {
        
      });
      },
      child: Row(
        children: [
          Icon(num >= 2 ? Icons.star : Icons.star_border, color: Colors.amber),
          Icon(num >= 4 ? Icons.star : Icons.star_border, color: Colors.amber),
          Icon(num >= 6 ? Icons.star : Icons.star_border, color: Colors.amber),
          Icon(num >= 8 ? Icons.star : Icons.star_border, color: Colors.amber),
          Icon(num >= 10 ? Icons.star : Icons.star_border, color: Colors.amber),
        ],
      ),
    );
  }
}
