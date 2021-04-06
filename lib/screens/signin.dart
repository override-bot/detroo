import 'package:velocity_x/velocity_x.dart';

// ignore: unused_import
import '../main.dart';
import '../services/authHandler.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'signup.dart';



class SigninPage extends StatefulWidget {
  SigninPage({Key key}) : super(key: key);
  @override
  _SigninPageState createState() => _SigninPageState();
  }

class _SigninPageState extends State<SigninPage>{
 
  TextEditingController _emailField = TextEditingController();
   TextEditingController _passwordField = TextEditingController();
   var authHandler = new Auth();
   
    void showAlert(message){
   showDialog(context: context, builder: (context){
     return AlertDialog(
       content:Container(
          height: 90,
          width: MediaQuery.of(context).size.width/1.1,
          child: "$message".text.make(),
       ),
      
     );
   });
 }
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
        authHandler.signIn(_emailField.text, _passwordField.text).then((user){
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
          
        } ).catchError((e) {
            this.showAlert(e.message);
              });
    },
    child: "Sign In".text.semiBold.size(25).white.make(),
  )
).p16(),
Container(
  width: MediaQuery.of(context).size.width/1.1,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(15.0),
    color: Colors.white
  ),
  child: MaterialButton(
    onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpPage()
                      
                    ));
    },
    child: "Don't have an account? Sign up".text.semiBold.size(18).red600.make(),
  )
).p16()
         ],
       )
     ).make()
   )
 );
  }

}
  