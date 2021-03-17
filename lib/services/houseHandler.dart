import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/housemodel.dart';

//read data(multiple)
Stream<List<House>> fetchHouses(){
  var snaps = Firestore.instance.collection('houses').snapshots();
  return snaps.map((list) => 
     list.documents.map((doc) => House.fromFirestore(doc)).toList()
  );
}
//read single data in details page
Future<House> getHouseById(String houseId) async{
  var house = await Firestore.instance.collection('houses').document(houseId).get();
  if (house.exists != null){
    return Future(() => House.fromFirestore(house));
  }
  else {
    return Future<House>.value(null);
  }
}