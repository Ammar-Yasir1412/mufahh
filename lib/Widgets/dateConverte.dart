import 'package:intl/intl.dart';

dateConverte(_date) {
  var now = DateTime.now();
  var format = DateFormat('HH:mm a');
  var Dateformat = DateFormat('yyyy-MM-dd');
  var date = DateTime.fromMicrosecondsSinceEpoch(_date);
  var diff = date.difference(now).abs();
  var time = '';
  // print(
  //     "====>${diff.inSeconds}==${diff.inMinutes}==${diff.inHours}==${diff.inDays}");

  if (diff.inSeconds > 0 && diff.inMinutes == 0) {
    return time = diff.inSeconds.toString() + ' sec Ago';
  } else if (diff.inMinutes > 0 && diff.inHours == 0) {
    return time = diff.inMinutes.toString() + ' min Ago';
  } else if (diff.inHours > 0 && diff.inDays == 0) {
    return time = diff.inHours.toString() + ' hr Ago';
  } else if (diff.inDays < 10) {
    return time = diff.inDays.toString() + ' day Ago';
  } else {
    return time = Dateformat.format(date).toString();
  }
}
  //   Future<void> PostNow(data) async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   try {
  //     if (aboutCtrl.text != '' && tagCtrl.text != '' && url != 'null') {
  //       DateTime now = DateTime.now();
  //       var formattedDate = DateTime.now().microsecondsSinceEpoch;
  //       var _key = "${data["username"]}$formattedDate";
  //       await firestore.collection("Post").doc(_key).set({
  //         "about": aboutCtrl.text,
  //         "UID": data["UID"],
  //         "key": _key,
  //         "tag": tagCtrl.text,
  //         "type": postType,
  //         "ImgUrl": url,
  //         "postNow": formattedDate,
  //         "Profile": data["profile"],
  //         "name": data["username"],
  //         "Comments": {},
  //         "Likes": {},
  //       });
  //       await firestore.collection("Tags").doc(tagCtrl.text).set({
  //         "tag": tagCtrl.text,
  //         "number": 0,
  //       });

  //       Navigator.pop(context);
  //       snackBar(context, "Posted Sucessufully");
  //     } else {
  //       snackBar(context, "Please fill all text field");
  //     }
  //   } catch (e) {
  //     snackBar(context, e.toString());
  //   }
  // }
