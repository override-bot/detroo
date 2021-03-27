import 'dart:convert';
import 'package:velocity_x/velocity_x.dart';

import '../services/houseHandler.dart';

import '../models/housemodel.dart';
import 'package:flutter/material.dart';

class AllHouses extends StatefulWidget{
  AllHouses({Key key}): super(key:key);
  @override
  _AllHousesState createState() => _AllHousesState();
}
class _AllHousesState extends State<AllHouses>{
  @override
  Widget build(BuildContext context) {
   return StreamBuilder<List<House>>(
     stream: fetchHouses(),
     builder: (context, AsyncSnapshot<List<House>> snapshot){
          if(snapshot.hasData){
            var houses = snapshot.data;
            return ListView.builder(
              itemCount: houses != null? houses.length:0,
              itemBuilder: (_, int index){
                final House house = houses[index];
                return Container(
                  width: MediaQuery.of(context).size.width/1.1,
                  child: GestureDetector(
                    onTap: null,
                    child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           
                            Image.memory(
                              
                              base64Decode(house.imageUrl),
                              height: 100,
                              width: 100,),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  "#${house.price}".text.bold.purple600.size(20).make(),
                                  "${house.location}".text.purple600.size(8).make()
                                ],
                              ),
                            )
                            
                          ],
                    ),
                  ),
                );
              },
            );
          }
          else{
            return CircularProgressIndicator();
          }
     },
   );
  }

}