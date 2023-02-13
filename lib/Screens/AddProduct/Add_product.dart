import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../Functions/toast.dart';
import '../../Widgets/myLargeButton.dart';
import '../../Widgets/myTextField.dart';
import '../../constants/data.dart';

class Add_product extends StatefulWidget {
  final Map UserData;

  const Add_product({super.key, required this.UserData});

  @override
  State<Add_product> createState() => _Add_productState();
}

class _Add_productState extends State<Add_product> {
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController descriptionCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController priceCtrl = TextEditingController();
  var categoriesValue = categories[0];
  bool looding = false;
  var URL = null;
  var date = null;

  upload_pic() async {
    final XFile? _image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("product/${DateTime.now().toString()}");
    UploadTask uploadTask = ref.putFile(File(_image!.path));
    uploadTask.whenComplete(() async {
      var url = await ref.getDownloadURL();
      setState(() {
        URL = url;
      });
    }).catchError((onError) {
      toast(onError);
    });
    // return url;
  }

  void postdata() async {
    setState(() {
      looding = true;
    });
    final String title = titleCtrl.text.trim();
    final String description = descriptionCtrl.text;
    final String address = addressCtrl.text;
    final String price = priceCtrl.text;

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      if (title != '' && description != '' && address != '' && URL != null&& date != null) {
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('d MMM, yyyy').format(now);
        var key = now.microsecondsSinceEpoch.toString();
        await firestore.collection("products").doc(key).set({
          "Key": key,
          "UID": widget.UserData["UID"],
          "category": categoriesValue,
          "title": title,
          "bidClose": false,
          "description": description,
          "address": address,
          "price": price,
          "PhoneNo": widget.UserData["PhoneNo"],
          "ownerName": widget.UserData["username"],
          "url": URL,
          "JoinDate": formattedDate,
          "endDate": date,
        });
        // Navigator.of(context).pop();
        toast("Product Uploaded");
      } else {
        toast("Please fill all text field");
      }
    } catch (e) {
      toast(e.toString());
    }
    setState(() {
      looding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Container(),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                (Color.fromARGB(255, 99, 4, 4)),
                (Color.fromARGB(255, 99, 4, 4)),
                (Color.fromARGB(255, 223, 24, 17))
              ],
            ),
          ),
        ),
        title: const Text(
          "POST YOUR PRODUCT",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Text(
                  "Add Product Details",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              )),
          SizedBox(height: 10),
          // myTextField(
          //   context,
          //   "Add Category",
          //   Icons.category,
          //   categoryCtrl,
          // ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(255, 230, 228, 228),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.category,
                  color: Color.fromARGB(255, 209, 52, 52),
                ),
                SizedBox(width: 20),
                Container(
                  width: MediaQuery.of(context).size.width - 100,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: categoriesValue,
                    items: categories
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        categoriesValue = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10),
          myTextField(
            context,
            "Title",
            Icons.title,
            titleCtrl,
          ),
          SizedBox(height: 10),
          myTextField(
            context,
            "Description",
            Icons.clear_all,
            descriptionCtrl,
          ),
          SizedBox(height: 10),
          myTextField(
            context,
            "Address",
            Icons.location_city,
            addressCtrl,
          ),
          SizedBox(height: 10),
          myTextField(
            context,
            "Start Price",
            Icons.price_change,
            addressCtrl,
          ),
          SizedBox(height: 10),
          // Container(
          //     height: 20,
          //     width: MediaQuery.of(context).size.width,
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //     ),
          //     child: Center(
          //       child: const Text(
          //         "Add Product Photos",
          //         style: TextStyle(
          //             fontSize: 20,
          //             fontWeight: FontWeight.bold,
          //             color: Colors.black),
          //       ),
          //     )),

          Container(
            padding: EdgeInsets.only(left: 10),
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(255, 230, 228, 228),
            ),
            child: DateTimePicker(
              type: DateTimePickerType.date,
              dateMask: 'd MMM, yyyy',
              initialValue: DateTime.now().toString(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
             
              decoration: const InputDecoration(
                 icon: Icon(
                Icons.event,
                color: Color.fromARGB(255, 209, 52, 52),
              ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              onChanged: (val) => setState(() {
                
              }),
              validator: (val) {
                print(val);
                return null;
              },
              onSaved: (val) => print(val),
            ),
          ),

          GestureDetector(
            onTap: () {
              upload_pic();
            },
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                image: URL != null
                    ? DecorationImage(
                        image: NetworkImage(URL), fit: BoxFit.cover)
                    : const DecorationImage(
                        image: AssetImage("assets/Images/camera.jpg"),
                        fit: BoxFit.cover),
                shape: BoxShape.rectangle,
              ),
            ),
          ),
          SizedBox(height: 20),

          myLargeButton(context, "Post Now", () {
            postdata();
          }, looding),
        ],
      )),
    );
    Container();
  }
}
