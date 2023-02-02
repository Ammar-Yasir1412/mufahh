import 'dart:async';

import 'package:flutter/material.dart';

import 'package:mufahh/Screens/auth/login.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => InitState();
}

class InitState extends State<splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  startTimer() {
    var duration = Duration(seconds: 3);
    return new Timer(duration, loginRoute);
  }

  loginRoute() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return InitWidget();
  }
}

Widget InitWidget() {
  return Scaffold(
      body: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 214, 15, 15),
                gradient: LinearGradient(
                  colors: [
                    (Color.fromARGB(255, 99, 4, 4)),
                    (Color.fromARGB(255, 223, 24, 17))
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              )),
          Center(
            child: CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/Mufahh_logo.png'),
              backgroundColor: Color.fromARGB(255, 252, 250, 250),
            ),
          ),
        ],
      ));
}
