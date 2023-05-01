import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../Functions/toast.dart';
import '../Widgets/myTextField.dart';

var looding = false;

rateUS(context, postData, userData) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text("Rate Product"),
      content: rateStar(num),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            try {
              var data = postData['rate'] ?? [];
              data.add({
                "UID": userData["UID"],
              });
              await FirebaseFirestore.instance
                  .collection("products")
                  .doc(postData["Key"])
                  .update({"Bid": data});
              toast("Bid Uploaded");
            } catch (e) {
              print(e);
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

Widget rateStar(num) {
  return Row(
    children: [
      Icon(num <= 2 ? Icons.star : Icons.star_border, color: Colors.amber),
      Icon(num <= 4 ? Icons.star : Icons.star_border, color: Colors.amber),
      Icon(num <= 6 ? Icons.star : Icons.star_border, color: Colors.amber),
      Icon(num <= 8 ? Icons.star : Icons.star_border, color: Colors.amber),
      Icon(num <= 10 ? Icons.star : Icons.star_border, color: Colors.amber),
    ],
  );
}
