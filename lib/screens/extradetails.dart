//import 'dart:html';
import 'dart:io';

import 'package:detroo/screens/home.dart';
import 'package:detroo/services/userHandler.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';

class ExtraDetails extends StatefulWidget{
   ExtraDetails({Key key}): super(key:key);

    @override
  _ExtraDetailsState createState() => _ExtraDetailsState();
}

class _ExtraDetailsState extends State<ExtraDetails>{
  // ignore: non_constant_identifier_names
  TextEditingController _UsernameField = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController _UserPhoneField = TextEditingController();
  bool isUsername;
  bool isUserPhone;
   File _image;
    final picker = ImagePicker();
    Future  getImage() async {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      setState(() {
              if (pickedFile != null){
                _image = File(pickedFile.path);
              }
              else{
                print('no image');
              }
            });
    }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Additional Userinfo"),
          actions: [
            IconButton(icon: Icon(Icons.edit,color: Colors.purple), onPressed: 
            isUsername == true && isUserPhone == true && _image != null?
            ()async {
            uploadExtraDetail(_UsernameField.text, _UserPhoneField.text, _image).then((value) {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(context) => HomePage()), (route) => false);
            });}:null

            )
          ],
        ),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.purpleAccent,
                    shape: BoxShape.circle
                  ),
                  child: FloatingActionButton(onPressed: getImage,
                  child: _image == null?Icon(Icons.add_a_photo): Container(
                    width: 140,
            height: 140,
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                    fit: BoxFit.cover,
                    image: new FileImage(
                        _image)
                )
            )
                  )
                )
                 ).p16(),
                 Container(width: MediaQuery.of(context).size.width/1.2,
                 child: TextFormField(
                   onChanged: (text){
                   setState(() {
                                        if(text.length > 3){
                                          isUsername = true;
                                        }
                                        else{
                                          isUsername = false;
                                        }
                                      });
                 },
                 controller: _UsernameField,
                 decoration: InputDecoration(
                   hintText: "John",
                   labelText: "Name",
                   errorText: isUsername == false ? "Name should be more than 3 characters":null
                 ),
                 )).p16(),
                    
                 Container(width: MediaQuery.of(context).size.width/1.2,
                 child: TextFormField(
                   onChanged: (text){
                   setState(() {
                                        if(text.length == 11){
                                          isUserPhone = true;
                                        }
                                        else{
                                          isUserPhone = false;
                                        }
                                      });
                 },
                 controller: _UserPhoneField,
                 decoration: InputDecoration(
                   hintText: "07089322045",
                   labelText: "Phone number",
                   errorText: isUserPhone == false ? "PhoneNumber should be 11 characters":null
                 ),
                 )).p16(),
                  ],
            ),
          ).p16(),
      );
  }

}