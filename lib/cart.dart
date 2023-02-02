import 'package:flutter/material.dart';
import 'Itemdetails.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  var item = [
    {"name": 'Iphone x ', "picture": 'assets/iphone.jpg'},
  ] as List;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
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
                    "ITEM",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )),
          ),
          SliverGrid(
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Single_Item(
                    prod_name: item[index]['name'],
                    prod_picture: item[index]['picture'],
                  );
                },
                childCount: item.length,
              )),
        ]));
  }
}

class Single_Item extends StatelessWidget {
  final prod_name;
  final prod_picture;

  Single_Item({this.prod_name, this.prod_picture});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Hero(
            tag: prod_picture,
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ItemDetails(prod_name, prod_picture))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage(prod_picture), fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 25,
                    child: Text(prod_name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 23)),
                  ),
                  SizedBox(height: 7),

                ],
              ),
            )));
  }
}
