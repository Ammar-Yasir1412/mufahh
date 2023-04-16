import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
          "NOTIFICATIONS",
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
                      margin: EdgeInsets.all(10),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              data["title"],
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Positioned(
                              bottom: 3,
                              right: 6,
                              child: Text(data["JoinDate"])),
                        ],
                      ));
                }).toList());
          },
        ),
      ),
    );
  }

}