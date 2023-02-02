import 'package:flutter/material.dart';
import 'package:mufahh/Screens/Profile/Account.dart';
import 'package:mufahh/Screens/Profile/History.dart';
import 'package:mufahh/Screens/Profile/myads.dart';
import 'package:mufahh/Screens/Profile/Setings.dart';

import '../auth/Splash_Screen.dart';

class profile extends StatefulWidget {
  final Map UserData;

  const profile({super.key, required this.UserData});

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
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
              ],),
          ),
        ),
        title:  const Text(
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
                    Center(
                      child: Container(
                        height: 130,
                        width: 130,
                        child: widget.UserData["profile"] != null
                            ? CircleAvatar(
                          radius: 70,
                          backgroundImage:
                          NetworkImage(widget.UserData["profile"]),
                        )
                            : const CircleAvatar(
                          radius: 70,
                          backgroundImage:
                          AssetImage('assets/Images/profile.jpg'),
                        ),
                      ),
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
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Myadds(UserData: widget.UserData,)),
                            );
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(color: Colors.white),
                            child: const Text(
                              "My ADS",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => history()),
                              );
                            },
                            child: Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(color: Colors.white),
                                child: const Text(
                                  "History",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ))),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Settings(
                                          UserData: widget.UserData,
                                        )),
                              );
                            },
                            child: Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(color: Colors.white),
                                child: const Text(
                                  "Settings",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                )))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => splashscreen()),
                        );
                      },
                      child: AnimatedContainer(
                          alignment: Alignment.center,
                          duration: Duration(milliseconds: 300),
                          height: 45,
                          width: MediaQuery.of(context).size.width * 0.90,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  (Color.fromARGB(255, 99, 4, 4)),
                                  (Color.fromARGB(255, 223, 24, 17)),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(50)),
                          child: const Text(
                            "LOGOUT",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          )),
                    ),
                  ]),
            ),
          ),
        ]),
      ),
    );
  }
}
