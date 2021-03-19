import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
class House {
  String agentName;
  String houseId;
  String imageUrl;
  String houseDescription;
  String furtherDescription;
  String location;
  String price;
  bool isSold;
  String agentNumber;
  String addedAt;
  House({this.agentName,this.houseId, this.imageUrl, this.houseDescription, this.furtherDescription, this.location, this.price, this.isSold, this.agentNumber, this.addedAt});
  factory House.fromFirestore(DocumentSnapshot doc){
      var data = doc.data();
      return House(
        agentName: data['agentName'],
        houseId: data['HouseId'],
          imageUrl: data['imageUrl'],
          houseDescription: data['houseDescription'],
          furtherDescription: data['furtherDescription'],
          location: data['location'],
          price: data['price'],
          isSold: data['isSold'],
          agentNumber: data['agentNumber'],
          addedAt: data['addedAt']
      );
  }
}