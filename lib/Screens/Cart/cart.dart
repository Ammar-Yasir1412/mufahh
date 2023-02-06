import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Itemdetails.dart';

class Cart extends StatefulWidget {
  final Map UserData;

  const Cart({super.key, required this.UserData});

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _itemStream = FirebaseFirestore.instance
        .collection('products')
    // .orderBy('Date', descending: true)
        .where('winner', isEqualTo: widget.UserData["UID"])
    // .limitToLast(2)
        .snapshots();
    return Scaffold(
      backgroundColor: Color.fromARGB(226, 75, 41, 41),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  "Neared By",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
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
                      children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                        return         ItemDetails(
                          data: data,
                          UserData: widget.UserData,
                        );
                      }).toList(),
                    );
                  },
                ),
              ]),
        ),
      ),
    );
  }
}
