// ignore: unused_import
import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';
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
Future<String> uploadImage(image) async{
  String imageUri;
  var storageReference = FirebaseStorage.instance
      .ref()
      .child('users/${user.uid}');
    var  uploadTask = storageReference.putFile(image);
    // ignore: await_only_futures
    await uploadTask.whenComplete;
      print('uploaded');
      storageReference.getDownloadURL().then((fileURL){
        imageUri = fileURL;
      });
      return imageUri;
}
Future uploadExtraDetail(username, userPhone, displayPicture) async {
        String displayPictureURL = await uploadImage(displayPicture);
    return FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          "username": username,
          "userEmail": user.email,
          "userPhone": userPhone,
          "displayPicture": displayPictureURL,

    });
}