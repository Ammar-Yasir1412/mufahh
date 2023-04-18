import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:mufahh/Screens/auth/login.dart';

import '../../Functions/toast.dart';

class Forgot extends StatefulWidget {
  @override
  _ForgotState createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  Future<void> _resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);

      toast('Password reset email sent to ${emailController.text}');
      Navigator.pop(context);
    } catch (e) {
      toast(e.toString());
    }
  }

  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
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
                  child: Center(
                    child: Text(
                      "FORGOT PASSWORD",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 230, 222, 222)),
                    ),
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.09,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.57,
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/Mufahh_logo.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              const Text(
                "Don't Stress, just fil in your phone number",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              const Text(
                "or email address and we will help you",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              const Text(
                "reset your password",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child:  TextField(
                  controller: emailController,
                  cursorColor: Color(0xffF5591F),
                  decoration: InputDecoration(hintText: "Email"),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              InkWell(
                  onTap: () {
                    _resetPassword();
                  },
                  child: AnimatedContainer(
                      alignment: Alignment.center,
                      duration: Duration(milliseconds: 300),
                      height: 45,
                      width: MediaQuery.of(context).size.width * 0.90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(90)),
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
                      child: const Text(
                        "RESET PASSWORD",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ))),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: const Text(
                    "Back To Log In",
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
