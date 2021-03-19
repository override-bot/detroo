import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/housemodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authHandler.dart';
final User user = auth.currentUser;

//read data(multiple)
Stream<List<House>> fetchHouses(){
  var snaps = FirebaseFirestore.instance.collection('houses').snapshots();
  return snaps.map((list) => 
     list.docs.map((doc) => House.fromFirestore(doc)).toList()
  );
}
//read single data in details page
Future<House> getHouseById(String houseId) async{
  var house = await FirebaseFirestore.instance.collection('houses').doc(houseId).get();
  if (house.exists != null){
    return Future(() => House.fromFirestore(house));
  }
  else {
    return Future<House>.value(null);
  }
}
Future uploadHouse(imageUrl, houseDescription, furtherDescription, location, price) async{
      final userInfo = await FirebaseFirestore
                              .instance
                              .collection('users')
                              .doc(user.uid).get();
                        Map<String, dynamic> data(){
                          Map<String, dynamic> data = userInfo.data();
                          return data;
                        }
                        String agentName = data()['username'];
                        String agentNumber = data()['userPhone'];

                        return FirebaseFirestore.instance.collection('houses').add({
                          "agentName": agentName,
                          "imageUrl": imageUrl,
                          "houseDescription": houseDescription,
                          "furtherDescription": furtherDescription,
                          "location": location,
                          "price": price,
                          "isSold": false,
                          "addedAt": DateTime.now(),
                          "agentNumber": agentNumber
                        });
}