import 'package:flutter/material.dart';


class ItemDetails extends StatelessWidget {
  final Map data;
  final Map UserData;
  ItemDetails({Key? key, required this.data, required this.UserData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Hero(
                  tag: data["url"],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(data["url"]),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(height: 8),
                      Align(
                          child: Text(data["title"],
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                          alignment: Alignment.centerLeft),
                    ],
                  ),
                ),

                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text('Starting Bid : RS 13500 ', style: TextStyle(fontSize: 15)),
                    SizedBox(width: 2),
                  ],
                ),
                SizedBox(height: 25),
                Text("Production Description",
                    style: TextStyle(
                        fontSize: 22,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Text("RAM : 3 GB"),
                Text("ROM : 64 GB"),
                Text("Physical Condition : 9/10"),
                Text("Battery Health : 90%"),
                SizedBox(height: 20),
                Text("Reviews",
                    style: TextStyle(
                        fontSize: 22,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 7,),
                Text(
                  "1. Rana Moiz",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 7,),
                Text(" NYC Product and Price"),

                SizedBox(
                  height: 20,
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Center(
                      child: Text(
                        "Biddings ",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(

                  height: 20,
                    child: Text(
                      "Rana Moiz.......                              RS 15000 ",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                SizedBox(height: 7,),
                Container(

                  height: 20,

                    child: Text(
                      "Ghullam Hur                                  RS 14000 ",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),

                GestureDetector(
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => Add_bid()));
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
                      child: Text("ADD Bid",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold))),
                ),
              ],
            )),
      ),
    );
  }
}
