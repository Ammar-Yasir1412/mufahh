import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:mufahh/constants/style.dart';
import '../Categories/Categories.dart';
import '../AddProduct/Add_product.dart';
import '../Widgets/myTextField.dart';
import '../../../constants/data.dart';
import 'Searching.dart';
import 'item_card.dart';

class dashboard extends StatefulWidget {
  final Map UserData;

  const dashboard({super.key, required this.UserData});

  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  List<Color> colorLst = [
    Colors.pink.shade300,
    Colors.blue.shade300,
    Colors.green.shade300,
    Colors.red.shade300,
    Colors.purple.shade300,
    Colors.cyan.shade300,
    Colors.amber.shade300,
    Colors.brown.shade500,
    Colors.indigo.shade300,
    Colors.lime.shade300,
    Colors.teal.shade300,
    Colors.orange.shade300,
    Colors.pinkAccent,
    Colors.greenAccent,
    Colors.blue.shade300,
    Colors.purple.shade300,
  ];
  var _chosenValue = '';
  final Stream<QuerySnapshot> _itemStream = FirebaseFirestore.instance
      .collection('products')
      // .orderBy('Key', descending: true)
      .where('bidClose', isEqualTo: false)
      // .limitToLast(2)l
      .snapshots();
  final Stream<QuerySnapshot> _sliderStream =
      FirebaseFirestore.instance.collection('Slider').snapshots();
  final TextEditingController searchCTRL = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(226, 75, 41, 41),
            floatingActionButton: FloatingActionButton(
        onPressed: () {
           Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Add_product(UserData: widget.UserData,)),
        );
        },
        child: Icon(
          Icons.add,
          size: 32,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
      ),
    
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 30),
              
                    Container(
                      // padding: EdgeInsets.only(left: 10),
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 221, 219, 219),
                      ),
                      child: TextField(
                        controller: searchCTRL,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (val) {
                         Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Searching(
                                            UserData: widget.UserData,
                                            searching:val,
                                          )));
                        },
                        cursorColor: Color(0xffF5591F),
                        decoration: const InputDecoration(
                          labelText: "Searching",
                          prefixIcon: Icon(Icons.search),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                

                const SizedBox(
                  height: 10,
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: _sliderStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Container(
                          child: Column(
                        children: [
                          Text('Something went wrong'),
                        ],
                      ));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.data?.size == 0) {
                      return Center(child: const Text("No data found"));
                    }
                    return CarouselSlider(
                      options: CarouselOptions(height: 120.0),
                      items: snapshot.data!.docs.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(i["img"]),
                                  fit: BoxFit.fill,
                                ),
                                shape: BoxShape.rectangle,
                              ),
                            );
                          },
                        );
                      }).toList(),
                    );
                  },
                ),
                const SizedBox(height: 10),
                const Text(
                  "ALL CATEGORIES",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                    height: 90,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Categories(
                                            UserData: widget.UserData,
                                            categories: categories[index],
                                          )));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Center(
                                  child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image(
                                    image: AssetImage(
                                        categoriesIcon[index].toString()),
                                    height: 40,
                                  ),
                                  Text(categories[index]),
                                ],
                              )),
                            ),
                          );
                        })),
                const Text(
                  "Neared By",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
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
                        return item_card(
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
