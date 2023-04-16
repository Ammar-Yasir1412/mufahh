import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Widgets/myTextField.dart';
import '../home/home.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
TextEditingController textcontroler = TextEditingController();

// profileUpdate(context, title,key, UserData) async {
//   showModalBottomSheet(
//     context: context,
//     builder: (context) {
//       return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Wrap(
//           children: [
//             const Center(
//               child: Text(
//                 "Update Your Profile",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(18.0),
//               child: myTextField(
//                 context,
//                 "Add $title",
//                 Icons.title,
//                 textcontroler,
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 ElevatedButton(
//                     onPressed: () async {
//                       UserData[title] = textcontroler.text;
//                       await firestore
//                           .collection("users")
//                           .doc(UserData["UID"])
//                           .update({
//                         key: textcontroler.text,
//                       });
//                       textcontroler.clear();
//                     },
//                     child: const Text("Update")),
//                 ElevatedButton(
//                     onPressed: () async {
//                       Navigator.pop(context);
//                     },
//                     child: const Text("Cancel")),
//               ],
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }

class profileUpdate extends StatefulWidget {
  final String title;
  final String nKey;
  final Map UserData;
  const profileUpdate(
      {super.key,
      required this.title,
      required this.nKey,
      required this.UserData});

  @override
  State<profileUpdate> createState() => _profileUpdateState();
}

class _profileUpdateState extends State<profileUpdate> {
  @override
  Widget build(BuildContext context) {
    print("============>${widget.nKey}");
    return Scaffold(
      body: Wrap(
        children: [
          Center(
            child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      (Color.fromARGB(255, 99, 4, 4)),
                      (Color.fromARGB(255, 223, 24, 17))
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Update Your Profile",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: myTextField(
              context,
              "Add ${widget.nKey}",
              Icons.title,
              textcontroler,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    widget.UserData[widget.nKey] = textcontroler.text;
                    await firestore
                        .collection("users")
                        .doc(widget.UserData["UID"])
                        .update({
                      widget.nKey: textcontroler.text,
                    });
                    print("${widget.UserData}");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => home(
                                UserData: widget.UserData,
                              )),
                    );
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
    ;
  }
}
