import 'package:flutter/material.dart';

Widget myLargeButton(context, title, fun, loading) {
  return GestureDetector(
      onTap: () {
        fun();
      },
      child: AnimatedContainer(
          alignment: Alignment.center,
          duration: Duration(milliseconds: 300),
          height: 45,
          width: MediaQuery.of(context).size.width * 0.90,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  (Color.fromARGB(255, 99, 4, 4)),
                  (Color.fromARGB(255, 223, 24, 17)),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(50)),
          child: loading
              ? const CircularProgressIndicator( color: Colors.white,)
              : Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                )));
}
