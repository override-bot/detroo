import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:detroo/screens/housedetails.dart';
import 'package:detroo/services/userHandler.dart';
import 'package:velocity_x/velocity_x.dart';


import 'package:flutter/material.dart';

class UserHouses extends StatefulWidget{
  UserHouses({Key key}): super(key:key);
  @override
  _UserHousesState createState() => _UserHousesState();
}
class _UserHousesState extends State<UserHouses>{
  @override
  Widget build(BuildContext context) {
      Query houses = FirebaseFirestore.instance.collection('houses').where('agentId', isEqualTo: user.uid);
   return Scaffold(
      appBar: AppBar(
       elevation:1.0,
       
 leading: IconButton(icon: Icon(Icons.arrow_back_ios,color:Colors.purple), onPressed:(){Navigator.pop(context);}),
       title: "My Properties".text.bold.size(28).purple500.make(),
        actions: [
            IconButton(icon: Icon(Icons.search,color: Colors.purple[400]), onPressed:null)]
    ),
      body: SizedBox(
            height: 400.0,
  child:StreamBuilder<QuerySnapshot>(
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
   )));
  }

}