import 'package:flutter/material.dart';
import 'package:mufahh/Screens/Profile/profile.dart';

class Settings extends StatefulWidget {
  final Map UserData;

  const Settings({super.key, required this.UserData});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                child: Center(
                  child: Text(
                    "SETTINGS",
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
          Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Text(
                  "Change Your Name ",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              )),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 40,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 216, 211, 211),
            ),
            alignment: Alignment.center,
            child: TextField(
              cursorColor: Color(0xffF5591F),
              decoration: InputDecoration(
                hintText: "Enter Previous Name",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 40,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 216, 211, 211),
            ),
            alignment: Alignment.center,
            child: TextField(
              cursorColor: Color(0xffF5591F),
              decoration: InputDecoration(
                hintText: "Enter New Name",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Text(
                  "Change Your Password",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              )),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 40,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 216, 211, 211),
            ),
            alignment: Alignment.center,
            child: TextField(
              cursorColor: Color(0xffF5591F),
              decoration: InputDecoration(
                hintText: "Enter Previous password",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 40,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 216, 211, 211),
            ),
            alignment: Alignment.center,
            child: TextField(
              cursorColor: Color(0xffF5591F),
              decoration: InputDecoration(
                hintText: "Enter New Password",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),

          SizedBox(height: 20),
          Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Text(
                  "Change Your E-mail",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              )),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 40,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 216, 211, 211),
            ),
            alignment: Alignment.center,
            child: TextField(
              cursorColor: Color(0xffF5591F),
              decoration: InputDecoration(
                hintText: "Enter Previous E-mail",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 40,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 216, 211, 211),
            ),
            alignment: Alignment.center,
            child: TextField(
              cursorColor: Color(0xffF5591F),
              decoration: InputDecoration(
                hintText: "Enter New E-mail",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Text(
                  "Change Your Address",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              )),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 40,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 216, 211, 211),
            ),
            alignment: Alignment.center,
            child: TextField(
              cursorColor: Color(0xffF5591F),
              decoration: InputDecoration(
                hintText: "Enter Previous Address",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 40,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 216, 211, 211),
            ),
            alignment: Alignment.center,
            child: TextField(
              cursorColor: Color(0xffF5591F),
              decoration: InputDecoration(
                hintText: "Enter New Address",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Text(
                  "Change Your Number",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              )),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 40,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 216, 211, 211),
            ),
            alignment: Alignment.center,
            child: TextField(
              cursorColor: Color(0xffF5591F),
              decoration: InputDecoration(
                hintText: "Enter Previous Number",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 40,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 216, 211, 211),
            ),
            alignment: Alignment.center,
            child: TextField(
              cursorColor: Color(0xffF5591F),
              decoration: InputDecoration(
                hintText: "Enter New Number",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => profile(UserData: widget.UserData,))));
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
                  "Confirm Changes",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                )),
          ),
        ]),
      ),
    );
  }
}
