import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mufahh/Screens/auth/login.dart';
import 'package:intl/intl.dart';
import '../../Functions/toast.dart';
import '../Mobile App/Widgets/myLargeButton.dart';
import '../Mobile App/Widgets/myTextField.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => InitState();
}

class InitState extends State<Signup> {
  final TextEditingController nameCtrl = TextEditingController(text: "");
  final TextEditingController emailCtrl = TextEditingController(text: "");
  final TextEditingController passwordCtrl = TextEditingController(text: "");
  final TextEditingController phoneCtrl = TextEditingController(text: "");
  bool inCheck = false;
  bool NoData = false;
  bool looding = false;

  void register() async {
    setState(() {
      looding = true;
    });
    final String name = nameCtrl.text;
    final String email = emailCtrl.text.trim();
    final String phoneNo = phoneCtrl.text;
    final String password = passwordCtrl.text;

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      if (password.length > 8) {
        if (name != '' && email != '' && phoneNo != '' && password != '') {
          DateTime now = DateTime.now();
          String formattedDate = DateFormat('EEE d MMM').format(now);
          final UserCredential user = await auth.createUserWithEmailAndPassword(
              email: email, password: password);
          await firestore.collection("users").doc(user.user!.uid).set({
            "UID": user.user!.uid,
            "username": name,
            "email": email,
            "PhoneNo": phoneNo,
            "password": password,
            'user': "Enable",
            "JoinDate": formattedDate,
          });

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        } else {
          toast("Please fill all text field");
          setState(() {
            NoData = true;
          });
        }
      } else {
        toast("Please enter 8 digit password");
        setState(() {
          NoData = true;
        });
      }
      if (name != '' && email != '' && phoneNo != '' && password != '') {
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('EEE d MMM').format(now);
        final UserCredential user = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await firestore.collection("users").doc(user.user!.uid).set({
          "UID": user.user!.uid,
          "username": name,
          "email": email,
          "PhoneNo": phoneNo,
          "password": password,
          "JoinDate": formattedDate,
        });

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else {
        toast("Please fill all text field");
        setState(() {
          NoData = true;
        });
      }
    } catch (e) {
      toast(e.toString());
    }
    setState(() {
      looding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(90)),
                color: Colors.yellow,
                gradient: LinearGradient(
                  colors: [
                    (Color.fromARGB(255, 99, 4, 4)),
                    (Color.fromARGB(255, 223, 24, 17))
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    child: Text(
                      "SIGN UP",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    height: 100,
                    width: 100,
                  ),
                ],
              )),
            ),
            SizedBox(height: 20),
            myTextField(
              context,
              "Enter your Name",
              Icons.person,
              nameCtrl,
            ),
            SizedBox(height: 20),
            myTextField(
              context,
              "Enter your Email",
              Icons.person,
              emailCtrl,
            ),
            SizedBox(height: 20),
            myTextField(
              context,
              "Enter your Password",
              Icons.key,
              passwordCtrl,
            ),
            SizedBox(height: 20),
            myTextField(
              context,
              "Enter your Number",
              Icons.phone,
              phoneCtrl,
            ),
            SizedBox(height: 20),
            myLargeButton(context, "Sign up", register, looding),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(top: 20, left: 20, right: 10),
              alignment: Alignment.center,
              child: Center(
                child: Row(children: [
                  Text("Already have Account?   "),
                  GestureDetector(
                    onTap: (() => {
                          Navigator.pop(context,
                              MaterialPageRoute(builder: (context) => Login()))
                        }),
                    child: Text(
                      "Sign in",
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
