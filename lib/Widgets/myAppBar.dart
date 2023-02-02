import 'package:flutter/material.dart';

Widget myAppBar(title) {
  return AppBar(
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
          ],),
      ),
    ),
    title:  Text(
      title,
      style: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    ),
  );
}
