import 'package:flutter/material.dart';
import 'package:mufahh/shipping_details.dart';

class Add_bid extends StatefulWidget {
  const Add_bid({super.key});

  @override
  State<Add_bid> createState() => _Add_bidState();
}

class _Add_bidState extends State<Add_bid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
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
                  "ADD YOUR BID",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              )),
          SizedBox(height: 40),
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
            height: 40,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Color.fromARGB(255, 216, 211, 211),
            ),
            alignment: Alignment.center,
            child: Center(
              child: TextField(
                cursorColor: Color(0xffF5591F),
                decoration: InputDecoration(

                  hintText: "Enter Your Bid",
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 40),
          GestureDetector(
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Shipping_Details()))
            },
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 40),
              padding: EdgeInsets.only(left: 20, right: 20),
              alignment: Alignment.center,
              height: 50,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      (Color.fromARGB(255, 99, 4, 4)),
                      (Color.fromARGB(255, 223, 24, 17))
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(50)),
              child: Text(
                "SUBMIT",
                style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
