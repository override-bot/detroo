import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:detroo/screens/userHouse.dart';
import 'package:detroo/services/authHandler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'home.dart';

class DashBoard extends StatefulWidget {
  DashBoard({Key key}): super(key: key);
@override
_DashBoardState createState() => _DashBoardState();
}
class _DashBoardState extends State<DashBoard> {
  final User user = auth.currentUser;
  var authHandler = new Auth();

  @override
  Widget build(BuildContext context) {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  return FutureBuilder(
    future: users.doc(user.uid).get(),
    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
         
          if(snapshot.connectionState == ConnectionState.done){
            Map<String, dynamic>data = snapshot.data.data();
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.purple[300],
                elevation: 0.0,
                actions: [
                  IconButton(icon: Icon(Icons.logout, color: Colors.white), onPressed:()async{
                          authHandler.signOut().then((value){
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>
                            HomePage()), (route) => false);
                          });
                  } )
                ]
              ),
              body: ListView(
               
                children: [
                  Container(
                    height: 250,
                    color: Colors.purple[300],
                    child:  Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle
                  ),
                    child:Container(
                    width: 90,
            height: 90,
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                    fit: BoxFit.cover,
                    image: new NetworkImage(
                        data['displayPicture'])
                )
            )
                  
                  )
                 ).p16()
                  ),
                 Container(
                   height: 20,
                 ),
                   "Contact Details".text.bold.size(24).purple600.make(),
                      Divider(),
                       "Username".text.bold.size(20).black.make(),
                   "${data['username']}".text.size(20).black.make(),
                      Divider(),
                       "Email".text.bold.size(20).black.make(),
                    "${data['userEmail']}".text.size(20).black.make(),
                       Divider(),
                        "Phone Number".text.bold.size(20).black.make(),
                     "${data['userPhone']}".text.size(20).black.make(),
                   Divider(),
                
                  Container(
                    padding: EdgeInsets.only(top: 14, bottom: 14),
                    height: 60,
                    child:
                 GestureDetector(
                   onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserHouses(
                     
                    )));
                    
                  },
                  child: "My Properties".text.bold.size(24).purple600.make() ,
                 )),
                 Divider()
                ],
              )
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
    }
    );
  }
  
  
}