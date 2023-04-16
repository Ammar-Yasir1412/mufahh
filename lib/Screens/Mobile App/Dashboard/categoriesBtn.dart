import 'package:flutter/material.dart';
import '../Categories/Categories.dart';
Widget categoriesBtn(context, title, icon, UserData) {
  return Card(
    color: Colors.red.shade100,
    margin: const EdgeInsets.all(5),
    child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Categories(
                      UserData: UserData,
                      categories: title,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: Center(
            child: Row(
          children: [
            Icon(Icons.cabin),
            SizedBox(width: 4),
            Text(title),
          ],
        )),
      ),
    ),
  );
}
