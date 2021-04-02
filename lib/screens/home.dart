import 'package:detroo/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:flutter/material.dart';

import 'allHouses.dart';
import 'uploadhousepage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
  }
  class _HomePageState extends State<HomePage>{
   
int currentPage = 0;
PageController _myPage = PageController(initialPage: 0);
 @override
    Widget build(BuildContext context){
      return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          bottomNavigationBar: BottomAppBar(
            elevation:3.0,
            shape: CircularNotchedRectangle(),
            child: Container(
              height: 60,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(icon: Icon(Icons.home, color: currentPage == 0?Colors.purple[400]: Colors.black),
                 onPressed: (){
                   setState(() {
                                        _myPage.jumpToPage(0);
                                      });
                 }),
                  IconButton(icon: Icon(Icons.location_on, color: currentPage == 1?Colors.purple: Colors.black),
                 onPressed: (){
                   setState(() {
                                        _myPage.jumpToPage(1);
                                      });
                 }),
                   IconButton(icon: Icon(Icons.person, color: currentPage == 2?Colors.purple: Colors.black),
                 onPressed: (){
                   setState(() {
                                        _myPage.jumpToPage(2);
                                      });
                 }),
                 SizedBox(width: 40,)
              ],),
            ),
          ),
          body: PageView(
            controller: _myPage,
            onPageChanged: (int page){
              currentPage = page;
            },
            children: [
              AllHouses(),
              Center(child:Container(
                color:Colors.grey.shade200,
                child: "Coming Soon".text.size(20).make(),
              )),
              Center(child:Container(
                color:Colors.grey.shade200,
              )),
            ],
          ),
          floatingActionButton: Container(
            height: 55.0,
            width: 55.0,
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: FirebaseAuth.instance.currentUser != null?
                (){
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(context) => UploadPage()), (route) => true);
                }:
                (){
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(context) => SignUpPage()), (route) => true);
                }
                ,
                child: Icon(Icons.add_location_alt,
                color:Colors.white,),
                elevation: 3.0,
                
              ),
            ),
          ),
      );
    }
  }