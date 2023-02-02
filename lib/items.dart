import 'package:flutter/material.dart';
import 'Itemdetails.dart';


class Itm extends StatefulWidget {
  const Itm({super.key});

  @override
  State<Itm> createState() => _ItmState();
}

class _ItmState extends State<Itm> {

  @override
  Widget build(BuildContext context) {
    List images = [
      {"name": 'iphone 13 pro max', "picture": 'assets/iphone 13 pro max.jpg'},
      {"name": '12 pro max', "picture": 'assets/12 pro max.jpg'},
      {"name": 'iphone 11', "picture": 'assets/iphone 11.jpg'},
      {"name": '11 pro', "picture": 'assets/11 pro.jpg'},
      {"name": 'iphone 13', "picture": 'assets/iphone 13.jpg'},
      {"name": 'iphone 14', "picture": 'assets/iphone 14.jpg'},
      {"name": 'Samsung Note 22', "picture": 'assets/Samsung Note 22.jpg'},
      {"name": 'Samsung A51', "picture": 'assets/Samsung A51.jpg'},
      {"name": 'Samsung S10 ', "picture": 'assets/Samsung S10.jpg'},
    ];
    return Scaffold(
        backgroundColor: Color.fromARGB(226, 185, 43, 43),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
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
                      "PHONES",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              // Container(
              //     height: MediaQuery.of(context).size.height * 0.1,
              //     width: MediaQuery.of(context).size.width,
              //     decoration: BoxDecoration(
              //       gradient: LinearGradient(
              //         colors: [
              //           (Color.fromARGB(255, 99, 4, 4)),
              //           (Color.fromARGB(255, 223, 24, 17))
              //         ],
              //         begin: Alignment.topCenter,
              //         end: Alignment.bottomCenter,
              //       ),
              //     ),
              //     child: Center(
              //       child: Text(
              //         "CHOOSE CATEGORY",
              //         style: TextStyle(
              //             fontSize: 20,
              //             fontWeight: FontWeight.bold,
              //             color: Colors.white),
              //       ),
              //     )),
              SizedBox(
                height: 20,
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: images.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0),
                itemBuilder: (BuildContext context, int index) {
                  return Card(

                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => ItemDetails( images[index]['name'], images[index]['picture'],)));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(images[index]['picture']),
                                fit: BoxFit.fill,
                              ),
                              shape: BoxShape.rectangle,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  color: Colors.black.withOpacity(0.5),
                                  height: 25,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        images[index]['name'],
                                        style:
                                        const TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ));
                },
              ),
            ],
          ),
        ));
  }
}
