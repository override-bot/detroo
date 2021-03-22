import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authHandler.dart';
final User user = auth.currentUser;
Future<UserExtra> getUser() async{
  var house = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
  if (house.exists != null){
    return Future(() => UserExtra.fromFirestore(house));
  }
  else {
    return Future<UserExtra>.value(null);
  }
}
Future uploadExtraDetail(username, userPhone, displayPicture) async {
          List<int> displayPictureBytes = displayPicture.readAsBytesSync();
          String displayPictureB64 = base64Encode(displayPictureBytes);
    return FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          "username": username,
          "userEmail": user.email,
          "userPhone": userPhone,
          "displayPicture": displayPictureB64,

    });
}