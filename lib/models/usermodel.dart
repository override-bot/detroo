import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
class UserExtra{
  String username;
  String userPhone;
  String displayPicture;
  String userEmail;
  UserExtra({this.username, this.displayPicture, this.userPhone, this.userEmail});
  factory UserExtra.fromFirestore(DocumentSnapshot doc){
      var data = doc.data();
      return UserExtra(
        username: data['username'],
        userPhone: data['userPhone'],
        displayPicture: data['displayPicture'],
        userEmail: data['userEmail']
      );
}
}