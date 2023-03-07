import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Widgets/myTextField.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
TextEditingController textcontroler = TextEditingController();

profileUpdate(context, title, UserData) async {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          children: [
            const Center(
              child: Text(
                "Update Your Profile",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: myTextField(
                context,
                "Add $title",
                Icons.title,
                textcontroler,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      UserData[title] = textcontroler.text;
                      await firestore
                          .collection("users")
                          .doc(UserData["UID"])
                          .update({
                        title: textcontroler.text,
                      });
                      textcontroler.clear();
                    },
                    child: const Text("Update")),
                ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel")),
              ],
            ),
          ],
        ),
      );
    },
  );
}
