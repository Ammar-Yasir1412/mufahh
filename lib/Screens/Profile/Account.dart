import 'package:flutter/material.dart';
import 'package:mufahh/Screens/Profile/profileUpdate.dart';

import '../../Widgets/myAppBar.dart';

class Account extends StatefulWidget {
  final Map UserData;

  const Account({super.key, required this.UserData});

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Text(
          "ACCOUNT DETAILS",
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Row(
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
                    ]),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: const Text("ACCOUNT INFORMATION",
                  style: TextStyle(
                      letterSpacing: 1,
                      fontSize: 17,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    textCard(context, "Full Name", "username", widget.UserData),
                    const Text('Email',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.75)),
                    SizedBox(height: 3),
                    Text(
                      widget.UserData["email"],
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    SizedBox(height: 20),
                    textCard(context, "Phone", "PhoneNo", widget.UserData),
                    textCard(context, "Address", "address", widget.UserData),
                    textCard(context, "Gender", "gender", widget.UserData),
                    const Text('Join Date',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.75)),
                    const SizedBox(height: 3),
                    Text(
                      widget.UserData["JoinDate"],
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                      width: 15,
                    ),
                  ]),
            ),
          ])),
    );
  }
}

Widget textCard(context, title, key, UserData) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.75)),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => profileUpdate(
                          title: title, nKey: key, UserData: UserData)),
                );
              },
              child: Icon(
                Icons.edit,
                size: 16,
              )),
        ],
      ),
      Text(
        UserData[key],
        style: TextStyle(color: Colors.grey, fontSize: 15),
      ),
      SizedBox(height: 20),
    ],
  );
}
