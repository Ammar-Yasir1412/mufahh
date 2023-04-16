import 'package:flutter/material.dart';
import 'package:mufahh/Screens/Admin%20Panel/producteScreen.dart';
import 'package:mufahh/Screens/Admin%20Panel/userScreen.dart';

class bottumNavAdmin extends StatefulWidget {
  final Map UserData;

  const bottumNavAdmin({super.key, required this.UserData});
  @override
  _bottumNavAdminState createState() => _bottumNavAdminState();
}

class _bottumNavAdminState extends State<bottumNavAdmin> {
  int currentTab = 0;

  final PageStorageBucket bucket = PageStorageBucket();
  @override
  void initState() {
    CurrentScreen = userScreen();
    super.initState();
  }

  late Widget CurrentScreen;
  @override
  Widget build(BuildContext context) {
    print("${widget.UserData}");
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 214, 15, 15),

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
                        CurrentScreen = userScreen();
                        currentTab = 0;
                      });
                    },
                    child: Icon(Icons.person,
                        size: 32,
                        color: currentTab == 0 ? Colors.red : Colors.grey),
                  ),
                  MaterialButton(
                    minWidth: 60,
                    onPressed: () {
                      setState(() {
                        CurrentScreen = producteScreen();
                        currentTab = 1;
                      });
                    },
                    child: Icon(Icons.notifications,
                        size: 32,
                        color: currentTab == 1 ? Colors.red : Colors.grey),
                  ),
                ])),
      ),
    );
  }
}
