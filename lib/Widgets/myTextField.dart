import 'package:flutter/material.dart';

Widget myTextField(context, title,icon, Ctrl,){
  return  Container(
    padding: EdgeInsets.only(left: 10),
    width: MediaQuery.of(context).size.width * 0.9,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Color.fromARGB(255, 216, 211, 211),
    ),
    child: TextField(
      controller: Ctrl,
      cursorColor: Color(0xffF5591F),
      decoration: InputDecoration(
        icon: Icon(
          icon,
          color: Color.fromARGB(255, 105, 97, 97),
        ),
        hintText: title,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    ),
  );}