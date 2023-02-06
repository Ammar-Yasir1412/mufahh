import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:mufahh/Screens/Categories/Categories.dart';

import '../../constants/data.dart';
import 'Itemdetails.dart';

class Cart extends StatefulWidget {
  final Map UserData;

  const Cart({super.key, required this.UserData});

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List images = [
    {"name": 'Phone ', "picture": 'assets/iphone.jpg'},
    {"name": 'Car ', "picture": 'assets/Civic.jpg'},
    {"name": 'Furniture ', "picture": 'assets/sofa.jpg'},
    {"name": 'Home Appliances ', "picture": 'assets/Refri.jpg'}
  ];


  final Stream<QuerySnapshot> _itemStream = FirebaseFirestore.instance
      .collection('products')
  // .orderBy('Date', descending: true)
      .where('bidClose', isEqualTo: false)
  // .limitToLast(2)l
      .snapshots();
  final Stream<QuerySnapshot> _sliderStream =
  FirebaseFirestore.instance.collection('Slider').snapshots();

  @override
  Widget build(BuildContext context) {
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
                      return Center(child: const Text("No data found"));
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
                // SizedBox(height: 10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     Container(
                //       margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                //       alignment: Alignment.center,
                //       child: const Text(
                //         "Categories ",
                //         style: TextStyle(color: Colors.yellow),
                //       ),
                //     ),
                //     GestureDetector(
                //       onTap: (() => {
                //             Navigator.push(
                //               context,
                //               MaterialPageRoute(builder: (context) => Cate()),
                //             )
                //           }),
                //       child: Container(
                //         margin: const EdgeInsets.only(top: 20, left: 20, right: 10),
                //         alignment: Alignment.center,
                //         child: const Text(
                //           "See more >>",
                //           style: TextStyle(color: Colors.yellow),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 15),
                // GridView.builder(
                //   shrinkWrap: true,
                //   itemCount: images.length,
                //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 2,
                //       crossAxisSpacing: 4.0,
                //       mainAxisSpacing: 4.0),
                //   itemBuilder: (BuildContext context, int index) {
                //     return Card(
                //         child: GestureDetector(
                //       onTap: () {
                //         Navigator.push(context,
                //             MaterialPageRoute(builder: (context) => Itm()));
                //       },
                //       child: Container(
                //           decoration: BoxDecoration(
                //             image: DecorationImage(
                //               image: AssetImage(images[index]['picture']),
                //               fit: BoxFit.fill,
                //             ),
                //             shape: BoxShape.rectangle,
                //           ),
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.end,
                //             children: [
                //               Container(
                //                 color: Colors.black.withOpacity(0.5),
                //                 height: 25,
                //                 child: Row(
                //                   mainAxisAlignment: MainAxisAlignment.center,
                //                   children: [
                //                     Text(
                //                       images[index]['name'],
                //                       style: const TextStyle(color: Colors.white),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ],
                //           )),
                //     ));
                //   },
                // ),
              ]),
        ),
      ),
    );
  }
}
