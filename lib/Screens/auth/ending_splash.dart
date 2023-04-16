import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mufahh/Screens/auth/Splash_Screen.dart';



class ending_splashscreen extends StatefulWidget {
  const ending_splashscreen({super.key});

  @override
  State<ending_splashscreen> createState() => InitState();
}

class InitState extends State<ending_splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  startTimer() {
    var duration = Duration(seconds: 2);
    return new Timer(duration, loginRoute);
  }

  loginRoute() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => splashscreen()));
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
              child: Text(
                "* THANKS *",
                style: TextStyle(
                    color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
              )),
        ],
      ));
}
