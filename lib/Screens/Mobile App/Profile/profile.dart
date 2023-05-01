import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mufahh/Screens/Mobile%20App/Profile/Account.dart';
import 'package:mufahh/Screens/Mobile%20App/Profile/History.dart';
import 'package:mufahh/Screens/Mobile%20App/Profile/myads.dart';
import '../../../Functions/toast.dart';
import '../Widgets/myLargeButton.dart';
import '../../auth/Splash_Screen.dart';
import 'Favourite/myFavourite.dart';

class profile extends StatefulWidget {
  final Map UserData;

  const profile({super.key, required this.UserData});

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool imageLooding = false;
  var progressshow = 0.0;

  late final XFile? image;
  pickImage() async {
    setState(() {
      imageLooding = true;
    });
    image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 45);
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("${DateTime.now().microsecondsSinceEpoch}");
    UploadTask uploadTask = ref.putFile(File(image!.path));
    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      double progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
      setState(() {
        progressshow = progress;
      });
    });
    uploadTask.whenComplete(() async {
      var url = await ref.getDownloadURL();

      await firestore.collection("users").doc(widget.UserData["UID"]).update({
        "profile": url,
      });
      setState(() {
        widget.UserData["profile"] = url;
        imageLooding = false;
      });
    }).catchError((onError) {
      setState(() {
        imageLooding = false;
      });
      toast(onError.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                (Color.fromARGB(255, 99, 4, 4)),
                (Color.fromARGB(255, 99, 4, 4)),
                (Color.fromARGB(255, 223, 24, 17))
              ],
            ),
          ),
        ),
        title: const Text(
          "PROFILE",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
                Widget>[
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 130,
                          width: 130,
                          child: widget.UserData["profile"] != null
                              ? CircleAvatar(
                                  radius: 70,
                                  backgroundImage: NetworkImage(
                                      widget.UserData["profile"]),
                                )
                              : const CircleAvatar(
                                  radius: 70,
                                  backgroundImage:
                                      AssetImage('assets/Images/profile.jpg'),
                                ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                pickImage();
                              },
                              child: Container(
                                height: 44,
                                width: 44,
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent,
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.camera,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                    GestureDetector(
                      onTap: (() => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Account(
                                          UserData: widget.UserData,
                                        )))
                          }),
                      child: Container(
                        margin: EdgeInsets.only(top: 20, left: 20, right: 10),
                        alignment: Alignment.center,
                        child: Text(
                          "View & Edit Account Details",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textCard(
                            context,
                            Myadds(
                              UserData: widget.UserData,
                            ),
                            "My ADS"),
                        textCard(
                            context,
                            myFavourite(
                              UserData: widget.UserData,
                            ),
                            "My Favourite"),
                        textCard(
                            context,
                            history(
                              UserData: widget.UserData,
                            ),
                            "History"),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    myLargeButton(context, "LOGOUT", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => splashscreen()),
                      );
                    }, false),
                  ]),
            ),
          ),
        ]),
      ),
    );
  }
}

Widget textCard(context, page, title) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );
    },
    child: Card(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ),
  );
}
