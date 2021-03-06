import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:detroo/screens/housedetails.dart';
import 'package:velocity_x/velocity_x.dart';


import 'package:flutter/material.dart';

class AllHouses extends StatefulWidget{
  AllHouses({Key key}): super(key:key);
  @override
  _AllHousesState createState() => _AllHousesState();
}
class _AllHousesState extends State<AllHouses>{
  @override
  Widget build(BuildContext context) {
      Query houses = FirebaseFirestore.instance.collection('houses');
   return Scaffold(
     appBar: AppBar(
       elevation:1.0,
       title: "Property List".text.bold.size(32).purple800.make(),
        actions: [
            IconButton(icon: Icon(Icons.search,color: Colors.purple[400]), onPressed:null)]
    ),
  
  body:StreamBuilder<QuerySnapshot>(
     stream: houses.snapshots(),
     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasData){
           
            return ListView(
            
                children: snapshot.data.docs.map((DocumentSnapshot document){

return Container(
   padding: EdgeInsets.only(top:10, bottom: 10),
  color: Colors.grey[200],
                 width: 450,
                  child:new ListTile(onTap:(){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HouseDetails(
                      postId:document.id
                    )));
                  },
                  leading: Container(
                    width: 150,
            height: 150,
            decoration: new BoxDecoration(
               
                image: new DecorationImage(
                    fit: BoxFit.cover,
                    image: new NetworkImage(
                       document.data()['imageUrl'],)
                )
            )
                  ),
                  
                  title: "${document.data()['price']}".text.bold.size(20).purple900.make(),
                  subtitle: "${document.data()['houseDescription']}\n${document.data()['location']}".text.gray800.size(16).make(),
                )
 );
                }).toList()
              );
          }
          else{
            return Center(
              child:CircularProgressIndicator());
          }
     },
   ));
  }

}