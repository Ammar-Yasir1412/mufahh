import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mufahh/Widgets/smallbutton.dart';

import '../Functions/toast.dart';

Widget myDelete(context, collection, doc) {
  return CircleAvatar(
    backgroundColor: Colors.white,
    child: IconButton(
        onPressed: () async {
          delete() async {
            Navigator.pop(context);
            FirebaseFirestore firestore = FirebaseFirestore.instance;
            await firestore
                .collection(collection)
                .doc(doc)
                .delete()
                .then((value) => toast("Delete successfully"))
                .catchError((onError) => toast(onError.toString()));
          }

          AlertDialog alert = AlertDialog(
            // title: Center(child: Text("Error")),
            content: Text("Are you sure you want to Delete"),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  smallbutton("Done", () {
                    delete();
                  }),
                  smallbutton("Cancel", () {
                    Navigator.pop(context);
                  }),
                ],
              )
            ],
          );
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
        },
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        )),
  );
}
