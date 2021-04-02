import 'dart:io';

import '../services/houseHandler.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

import 'home.dart';
class UploadPage extends StatefulWidget{
  UploadPage({Key key}): super(key:key);
  @override
  UploadPageState createState() => UploadPageState();
}
class UploadPageState extends State<UploadPage>{
  bool isDescription, isFDescription, isPrice, isLocation;
  TextEditingController _descriptionField = TextEditingController();
  TextEditingController _fDescriptionField = TextEditingController();
  TextEditingController _priceField = TextEditingController();
  TextEditingController _locationField = TextEditingController();
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
    resizeToAvoidBottomInset: false ,
    appBar: AppBar(
          actions: [
            IconButton(icon: Icon(Icons.edit,color: Colors.purple), onPressed: 
            isDescription == true && isFDescription == true && _image != null && isPrice == true && isLocation ==true?
            ()async {
           uploadHouse(_image, _descriptionField.text, _fDescriptionField.text, _locationField.text, _priceField.text).then((value) {
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
                  child: _image == null?Icon(Icons.add_a_photo):Container(
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
                                        if(text.length > 10){
                                          isDescription = true;
                                        }
                                        else{
                                          isDescription = false;
                                        }
                                      });
                 },
                   controller: _descriptionField,
                 decoration: InputDecoration(
                   hintText: "one room self contain",
                   labelText: "Type of House",
                   errorText: isDescription == false ? "Name should be more than 10 characters":null
                 ),
                 )).p16(),
                    Container(width: MediaQuery.of(context).size.width/1.2,
                 child: TextFormField(
                   onChanged: (text){
                   setState(() {
                                        if(text.length > 10){
                                          isFDescription = true;
                                        }
                                        else{
                                          isFDescription = false;
                                        }
                                      });
                 },
                   controller: _fDescriptionField,
                 decoration: InputDecoration(
                   hintText: "24/7 power supply, adequate security, close to school",
                   labelText: "Description",
                   errorText: isFDescription == false ? "Descriptipn should be more than 10 characters":null
                 ),
                 )).p16()
                 ,
                   Container(width: MediaQuery.of(context).size.width/1.2,
                 child: TextFormField(
                   onChanged: (text){
                   setState(() {
                                        if(text.length > 4){
                                          isPrice = true;
                                        }
                                        else if (text.contains(new RegExp(r'[a-zA-Z]'))){
                                          isPrice = false;
                                        }
                                        else{
                                          isPrice = false;
                                        }
                                      });
                 },
                   controller: _priceField,
                 decoration: InputDecoration(
                   hintText: "5,000",
                   labelText: "Price",
                   errorText: isFDescription == false ? "Wrong format":null
                 ),
                 )).p16(),
                   Container(width: MediaQuery.of(context).size.width/1.2,
                 child: TextFormField(
                   onChanged: (text){
                   setState(() {
                                        if(text.length > 2){
                                          isLocation= true;
                                        }
                                       
                                        else{
                                          isLocation = false;
                                        }
                                      });
                 },
                   controller: _locationField,
                 decoration: InputDecoration(
                   hintText: "Odenigwe",
                   labelText: "Location",
                   errorText: isFDescription == false ? "Cannot be empty":null
                 ),
                 )).p16()
        ],
      ),
    ),
  );
  }

}