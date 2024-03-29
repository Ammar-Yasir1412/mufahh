import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mufahh/Screens/auth/sign_up.dart';
import 'package:mufahh/Screens/Mobile%20App/home/home.dart';
import 'package:intl/intl.dart';
import '../../Functions/toast.dart';
import '../Admin Panel/bottumNavAdmin.dart';
import '../Mobile App/Widgets/myLargeButton.dart';
import '../Mobile App/Widgets/myTextField.dart';
import 'forgot.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailCtrl =
      TextEditingController();
  final TextEditingController passwordCtrl =
      TextEditingController();
  //   final TextEditingController emailCtrl =
  //     TextEditingController(text: "aaa@gmail.com");
  // final TextEditingController passwordCtrl =
  //     TextEditingController(text: "Leq 1412");
  bool inCheck = false;
  bool NoData = false;
  bool looding = false;

  void register() async {
    setState(() {
      looding = true;
    });
    var UserData;
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final String useremail = emailCtrl.text.trim();
    final String userpassword = passwordCtrl.text;
    try {
      if (useremail != '' && userpassword != '') {
        final UserCredential user = await auth.signInWithEmailAndPassword(
            email: useremail, password: userpassword);
        final DocumentSnapshot snapshot =
            await firestore.collection("users").doc(user.user?.uid).get();
        // storage.write(key: "UID", value: user.user?.uid);
        final data = snapshot.data();
        setState(() {
          UserData = data;
        });
        print('======>${UserData["user"]}');
        if (UserData["admin"] == true) {
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const bottumNavAdmin()),
          );
        } else if (UserData["user"] == "Disable") {
          toast("Your account is disable by admin");
        } else if (UserData["user"] == "Delete") {
          toast("Your account is delete by admin");
        } else {
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => home(
                      UserData: UserData,
                    )),
          );
        }
      } else {
        toast("Please fill all text field");
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(90)),
                  color: Colors.yellow,
                  gradient: LinearGradient(
                    colors: [
                      (Color.fromARGB(255, 61, 41, 41)),
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
                  children: const [
                    SizedBox(),
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/Mufahh_logo.png'),
                      backgroundColor: Color.fromARGB(255, 252, 250, 250),
                    ),
                    Text(
                      "LOGIN",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              myTextField(
                context,
                "Enter your Email",
                Icons.person,
                emailCtrl,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              myTextField(
                context,
                "Enter your Password",
                Icons.key,
                passwordCtrl,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              myLargeButton(context, "Login", register, looding),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              const Text(
                "Don't have an account?",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              myLargeButton(context, "SIGN UP", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Signup()),
                );
              }, false),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              myLargeButton(context, "FORGOT PASSWORD", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Forgot()),
                );
              }, false),
            ],
          ),
        ),
      ),
    );
  }
}
