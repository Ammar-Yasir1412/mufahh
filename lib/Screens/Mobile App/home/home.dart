import 'package:flutter/material.dart';
import '../Cart/cart.dart';
import '../Dashboard/dashboard.dart';
import '../AddProduct/Add_product.dart';
import '../../../notification.dart';
import '../Profile/profile.dart';

class home extends StatefulWidget {
  final Map UserData;

  const home({super.key, required this.UserData});
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  int currentTab = 0;



  final PageStorageBucket bucket = PageStorageBucket();
@override
  void initState() {
   CurrentScreen = dashboard(UserData:widget.UserData,);
    super.initState();
  }
  late Widget CurrentScreen;
  @override
  Widget build(BuildContext context) {
                        print("${widget.UserData}");
    return Scaffold(
      body: PageStorage(bucket: bucket, child: CurrentScreen),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
            height: 60,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 50,
                    onPressed: () {
                      setState(() {
                        CurrentScreen = dashboard(UserData: widget.UserData,);
                        currentTab = 0;
                      });
                    },
                    child: Icon(Icons.home,
                        size: 32,
                        color: currentTab == 0 ? Colors.red : Colors.red.shade200),
                  ),
                  MaterialButton(
                    minWidth: 60,
                    onPressed: () {
                      setState(() {
                        CurrentScreen = notification(UserData: widget.UserData,);
                        currentTab = 1;
                      });
                    },
                    child: Icon(Icons.notifications,
                        size: 32,
                        color: currentTab == 1 ? Colors.red : Colors.red.shade200),
                  ),
                  MaterialButton(
                    minWidth: 60,
                    onPressed: () {
                      setState(() {
                        CurrentScreen = Cart(UserData: widget.UserData,);
                        currentTab = 2;
                      });
                    },
                    child: Icon(Icons.shopping_cart,
                        size: 32,
                        color: currentTab == 2 ? Colors.red : Colors.red.shade200),
                  ),
                  MaterialButton(
                    minWidth: 60,
                    onPressed: () {
                      setState(() {
                        CurrentScreen = profile(UserData: widget.UserData,);
                        currentTab = 3;
                      });
                    },
                    child: Icon(Icons.person,
                        size: 32,
                        color: currentTab == 3 ? Colors.red : Colors.red.shade200),
                  ),
                ])),
      ),
    );
  }
}
