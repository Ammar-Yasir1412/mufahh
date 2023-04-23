import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'item_card.dart';

class Searching extends StatefulWidget {
  final String searching;
  final Map UserData;

  const Searching(
      {super.key, required this.searching, required this.UserData});

  @override
  State<Searching> createState() => _SearchingState();
}

class _SearchingState extends State<Searching> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _itemStream = FirebaseFirestore.instance
        .collection('products')
        // .orderBy('Date', descending: true)
        .where('title', isGreaterThanOrEqualTo: widget.searching)
        // .limitToLast(2)l
        .snapshots();
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
          title: const Text(
            "Searching",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: _itemStream,
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
                  controller: ScrollController(),
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                        if (data["type"]=="aprove") {
                          return item_card(
                            data: data,
                            UserData: widget.UserData,
                          );
                        } else {
                          return Container();
                        }
                      }).toList(),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
