import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
class HouseDetails extends StatefulWidget{
  final String postId;
  HouseDetails({Key key, @required this.postId}): super(key:key);
  @override
  _HouseDetailsState createState()=> _HouseDetailsState();

}
class _HouseDetailsState extends State<HouseDetails>{
  String formatTime(Timestamp timestamp){
    var format = new DateFormat('y-MM-dd');
    return format.format(timestamp.toDate());
  }
@override
Widget build(BuildContext context){
  CollectionReference houses = FirebaseFirestore.instance.collection('houses');
  return FutureBuilder<DocumentSnapshot>(
    future: houses.doc(widget.postId).get(),
    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
      if(snapshot.connectionState == ConnectionState.done){
        Map<String, dynamic>data = snapshot.data.data();
        return Scaffold(
            appBar: PreferredSize(child: AppBar(
              elevation:0.0,
              leading: IconButton(icon: Icon(Icons.cancel, color:Colors.purple), onPressed:(){Navigator.pop(context);}),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(data['imageUrl'],
                  ),
                  fit: BoxFit.fill)
                ),
              )),
            
             preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.4)),
             body: ListView(
               children: [
                  "${data['houseDescription']}".text.bold.size(24).black.make(),
                 "#${data['price']}".text.size(20).black.make(),
                 Divider(),
                   "Property Info".text.bold.size(20).black.make(),
                 Container(
                   padding: EdgeInsets.only(top: 10),
                   width: MediaQuery.of(context).size.width/1.1,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                      
                       Container(
                         child:Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                              "Apartment for".text.bold.size(15).black.make(),
                               "Sale".text.size(15).black.make(),
                           ],
                         ) ,
                       ),
                        Divider(),
                        Container(
                         child:Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                              "Listed By".text.bold.size(16).black.make(),
                               "${data['agentName']}".text.size(16).black.make(),
                           ],
                         ) ,
                       ),
                        Divider(),
                        Container(
                         child:Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                              "Posted On".text.bold.size(16).black.make(),
                               "${formatTime(data['addedAt'])}".text.size(16).black.make(),
                           ],
                         ) ,
                       ),
                       Divider()
                       
                     ],
                   ),
                 ).p16(),
                 "Description".text.bold.size(20).black.make().py12(),
                 Container(
                   
                   width: MediaQuery.of(context).size.width,
                   child:  "${data['furtherDescription']}".text.size(16).black.make(),
                 )


               ],
             ),
             bottomNavigationBar: BottomAppBar(
               child: Container(child: 
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   TextButton(onPressed: () => UrlLauncher.launch('tel://${data['agentNumber']}'), child: Container(
                     color: Colors.purple,
                     
                     width: 120,
                     height: 50,
                     child: "Call us".text.bold.white.size(20).make().p16(),
                   )),
                    TextButton(onPressed: () => UrlLauncher.launch('mailto:${data['useremail']}'), child: Container(
                     width: 120,
                     height: 50,
                     color: Colors.purple,
                      child: "Email us".text.bold.size(20).white.make().p16(),
                   ))
                 ],
               ),),
             ),
        );
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}
}