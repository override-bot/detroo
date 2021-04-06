import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';
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
Future<String> uploadImage(image) async{
 // String imageUri;
  var storageReference = FirebaseStorage.instance
      .ref()
      .child('houses/${Path.basename(image.path)}');
    var  uploadTask = storageReference.putFile(image);
    // ignore: await_only_futures
    await uploadTask.whenComplete;
      print('uploaded');
    String url = (await storageReference.getDownloadURL()).toString();
   return url;
}
Future uploadHouse(imageUrl, houseDescription, furtherDescription, location, price) async{
   String imageB64 = await uploadImage(imageUrl);
      final userInfo = await FirebaseFirestore
                              .instance
                              .collection('users')
                              .doc(user.uid).get();
                        Map<String, dynamic> data(){
                          Map<String, dynamic> data = userInfo.data();
                          return data;
                        }
                        String agentName = data()['username'];
                        String userEmail = data()['userEmail'];
                        String agentNumber = data()['userPhone'];
                        return FirebaseFirestore.instance.collection('houses').add({
                          "agentId": user.uid,
                          "agentName": agentName,
                          "imageUrl": imageB64,
                          "houseDescription": houseDescription,
                          "furtherDescription": furtherDescription,
                          "location": location,
                          "price": price,
                          "isSold": false,
                          "useremail": userEmail,
                          "addedAt": DateTime.now(),
                          "agentNumber": agentNumber
                        });
}