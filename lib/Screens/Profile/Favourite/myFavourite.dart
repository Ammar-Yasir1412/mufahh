import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Dashboard/item_card.dart';
import 'favourite_card.dart';

class myFavourite extends StatefulWidget {
  final Map UserData;

  const myFavourite({super.key, required this.UserData});

  @override
  State<myFavourite> createState() => _myFavouriteState();
}

class _myFavouriteState extends State<myFavourite> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _itemStream = FirebaseFirestore.instance
        .collection('products')
        // .orderBy('Date', descending: true)
        //     .where('UID', isEqualTo: widget.UserData["UID"])
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
            "MY Favourite",
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
                return const Center(child: Text("No data found"));
              }
              return GridView.extent(
                primary: false,
                padding: const EdgeInsets.all(16),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: (1 / 1.18),
                shrinkWrap: true,
                maxCrossAxisExtent: 200.0,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return favourite_card(
                    data: data,
                    UserData: widget.UserData,
                  );
                }).toList(),
              );
            },
          ),
        ));
  }
}
