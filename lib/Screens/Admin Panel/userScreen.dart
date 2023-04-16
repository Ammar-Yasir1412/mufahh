import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:expansion_card/expansion_card.dart';

class userScreen extends StatefulWidget {
  const userScreen({super.key});

  @override
  State<userScreen> createState() => _userScreenState();
}

class _userScreenState extends State<userScreen> {
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _itemStream = FirebaseFirestore.instance
        .collection('users')
        // .orderBy('Date', descending: true)
        // .where('UID', isEqualTo: widget.UserData["UID"])
        // .limitToLast(2)l
        .snapshots();
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
          "Users",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: _itemStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Card(
                    child: ExpansionCard(
                      margin: EdgeInsets.all(0),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${data["username"]}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Join Date:${data["JoinDate"]}",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          Text(
                            "${data["email"]}",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Ph.No: ${data["PhoneNo"]}",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    "Gender: ${data["gender"]}",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    "Address: ${data["address"]}",
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
                                    value: 'item1',
                                    child: Text(data["user"] != "Disable"
                                        ? 'Disable'
                                        : 'Disable'),
                                    onTap: () async {
                                      var type = data["user"] != "Disable"
                                          ? 'Disable'
                                          : 'Enable';
                                      await FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(data["UID"])
                                          .update({"user": type});
                                    },
                                  ),
                                  PopupMenuItem(
                                    value: 'item2',
                                    child: Text('Delete'),
                                    onTap: () async {
                                      await FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(data["UID"])
                                          .update({"user": "delete"});
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
      ),
    );
  }
}
