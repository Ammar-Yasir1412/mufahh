import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:expansion_card/expansion_card.dart';

import '../Mobile App/Widgets/dateConverte.dart';

class producteScreen extends StatefulWidget {
  const producteScreen({super.key});

  @override
  State<producteScreen> createState() => _producteScreenState();
}

class _producteScreenState extends State<producteScreen> {
  var page = 0;
  final Stream<QuerySnapshot> _AllStream =
      FirebaseFirestore.instance.collection('products').snapshots();
  final Stream<QuerySnapshot> _EnableStream = FirebaseFirestore.instance
      .collection('products')
      .where('type', isEqualTo: "panding")
      .snapshots();
  final Stream<QuerySnapshot> _DisableStream = FirebaseFirestore.instance
      .collection('products')
      .where('type', isEqualTo: "aprove")
      .snapshots();
  final Stream<QuerySnapshot> _DeleteStream = FirebaseFirestore.instance
      .collection('products')
      .where('type', isEqualTo: "reject")
      .snapshots();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Container(),
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
        title: const Text(
          "products",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(children: [
              Radio(
                value: 0,
                groupValue: page,
                onChanged: (val) {
                  setState(() {
                    page = 0;
                  });
                },
              ),
              const Text(
                'All',
                style: TextStyle(fontSize: 17.0),
              ),
              Radio(
                value: 1,
                groupValue: page,
                onChanged: (val) {
                  setState(() {
                    page = 1;
                  });
                },
              ),
              const Text(
                'Enable',
                style: TextStyle(fontSize: 17.0),
              ),
              Radio(
                value: 2,
                groupValue: page,
                onChanged: (val) {
                  setState(() {
                    page = 2;
                  });
                },
              ),
              const Text(
                'Disable',
                style: TextStyle(fontSize: 17.0),
              ),
              Radio(
                value: 3,
                groupValue: page,
                onChanged: (val) {
                  setState(() {
                    page = 3;
                  });
                },
              ),
              const Text(
                'Delete',
                style: TextStyle(fontSize: 17.0),
              ),
            ]),
            StreamBuilder<QuerySnapshot>(
              stream: page == 0
                  ? _AllStream
                  : page == 1
                      ? _EnableStream
                      : page == 2
                          ? _DisableStream
                          : page == 3
                              ? _DeleteStream
                              : _AllStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Column(
                    children: const [
                      Text('Something went wrong'),
                    ],
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data?.size == 0) {
                  return Center(child: const Text("No data found"));
                }
                return ListView(
                    shrinkWrap: true,
                    // physics: const BouncingScrollPhysics(
                    // parent: AlwaysScrollableScrollPhysics()),
                    controller: ScrollController(),
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return Card(
                        child: ExpansionCard(
                          margin: EdgeInsets.all(0),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        width: 100.00,
                                        height: 100.00,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          image: DecorationImage(
                                            image:
                                                NetworkImage('${data["url"]}'),
                                            fit: BoxFit.fill,
                                          ),
                                        )),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${data["title"]}",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Price: ${data["price"]}",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Text(
                                        "View: ${data["Live"]}",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Text(
                                        "Live: ${dateConverte(data["bidStart"], "Ago")}",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Text(
                                        "Close: ${dateConverte(data["bidEnd"], "Left")}",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 18),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Owner: ${data["PhoneNo"]}",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Text(
                                        "Ph.No: ${data["ownerName"]}",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Text(
                                        "Address: ${data["address"]}",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Text(
                                        "About: ${data["description"]}",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  PopupMenuButton<String>(
                                    onSelected: (value) {
                                      // Handle the selection of a menu item
                                    },
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        child: Text(data["type"] != "Panding"
                                            ? 'Aproved'
                                            : 'Reject'),
                                        onTap: () async {
                                          var type = data["type"] != "Disable"
                                              ? 'aprove'
                                              : 'reject';
                                          await FirebaseFirestore.instance
                                              .collection("products")
                                              .doc(data["Key"])
                                              .update({"type": type});
                                        },
                                      ),
                                      PopupMenuItem(
                                        value: 'item2',
                                        child: Text('Delete'),
                                        onTap: () async {
                                          await FirebaseFirestore.instance
                                              .collection("products")
                                              .doc(data["Key"])
                                              .update({"type": "delete"});
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList());
              },
            ),
          ],
        ),
      ),
    );
  }
}
