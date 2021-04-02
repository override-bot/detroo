import 'package:detroo/screens/extradetails.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: unused_import
import '../main.dart';
import '../services/authHandler.dart';
import 'package:flutter/material.dart';

import 'home.dart';



class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);
  @override
  _SignUpPageState createState() => _SignUpPageState();
  }

class _SignUpPageState extends State<SignUpPage>{
 
  TextEditingController _emailField = TextEditingController();
   TextEditingController _passwordField = TextEditingController();
   var authHandler = new Auth();
   String error = "";
    
  @override
  Widget build(BuildContext context) {
 return Scaffold(
   resizeToAvoidBottomInset: false,
   body: SafeArea(
     child: VxBox(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [
          "Detroo".text.purple600.semiBold.size(45).make().p16(),
        Container(
          width: MediaQuery.of(context).size.width/1.2,
         child: TextFormField(
           controller: _emailField,
           decoration: InputDecoration(
             hintText: "jdoe@gmail.com",
             labelText: "Email",
           ),
          
            
          )
     ).p16(),
       Container(
          width: MediaQuery.of(context).size.width/1.2,
         child: TextFormField(
           controller: _passwordField,
           obscureText: true,
           decoration: InputDecoration(
             labelText: "Password"
           ),
           
            
          )
    
).p16(),
Container(
  width: MediaQuery.of(context).size.width/1.5,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(15.0),
    color: Colors.purple
  ),
  child: MaterialButton(
    onPressed: () async{
        authHandler.signUp(_emailField.text, _passwordField.text).then((user){
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ExtraDetails()), (route) => false).catchError((e) => setState((){
            error = e;
          }));
        } );
    },
    child: "Sign up".text.semiBold.size(25).white.make(),
  )
).p16(),
Container(
  width: MediaQuery.of(context).size.width/1.5,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(15.0),
    color: Colors.purple
  ),
  child: MaterialButton(
    onPressed: () async{
        authHandler.signIn(_emailField.text, _passwordField.text).then((user){
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (route) => false).catchError((e) => setState((){
            error = e;
          }));
        } );
    },
    child: "Login".text.semiBold.size(25).white.make(),
  )
).p16()
         ],
       )
     ).make()
   )
 );
  }

}
  