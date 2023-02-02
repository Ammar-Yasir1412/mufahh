import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

addToCart(index, _Likes, UserData) async {
  var Likes = _Likes;
  if (Likes != null) {
    Likes[UserData["UID"]] = UserData["UID"];
  } else {
    Likes = {UserData["UID"]: UserData["UID"]};
  }
  await firestore.collection("products").doc(index).update({
    "Likes": Likes,
  });
}

UnaddToCart(index, _Likes, UserData) async {
// final Found = _Likes.containsValue('${UserData["UID"]}');
// print("=======1st====>>>${_Likes}"); // Earth
  final removedValue = _Likes.remove('${UserData["UID"]}');
// print("=======Remaning====>>>${_Likes}");
// print("=======removedValue====>>>${removedValue}");
  await firestore.collection("products").doc(index).update({
    "Likes": _Likes,
  });
}