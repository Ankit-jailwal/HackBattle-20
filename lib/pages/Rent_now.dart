import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:ieeecrop/Functions_and_route.dart';
import 'package:ieeecrop/pages/success.dart';


//Create new event or edit existing event Screen

class Rent_now extends StatefulWidget {
  @override
  _Rent_nowState createState() => _Rent_nowState();
}

class _Rent_nowState extends State<Rent_now> {
  final TextEditingController amountcontroller = TextEditingController();
  final TextEditingController descontroller = TextEditingController();
  final TextEditingController quantcontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  final maxLines = 5;
  File _image;
  File path;
  String _base64;

  Future get_image() async {
    final img = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = img;
      List<int> imageBytes = _image.readAsBytesSync();
      String imageB64 = base64Encode(imageBytes);
      _base64 = imageB64;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          title: Text("Rent your item here")
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: get_image,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: _image == null
                          ? Image.asset(
                        'assets/tractor.png',
                      )
                          : Image.file(_image),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: namecontroller,
                    decoration: InputDecoration(
                      labelText: "Name of item", //Name of event
                      labelStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w600),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: maxLines * 24.0,
                    child: TextField(
                      maxLines: maxLines,
                      controller: descontroller,
                      decoration: InputDecoration(
                        labelText: "Description",                             //Description
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w600,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    obscureText: false,
                    controller: quantcontroller,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      labelText: "Quantity",            //Maximum number of participants
                      labelStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w600),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: amountcontroller,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      labelText: "Amount",                       //Participants per team
                      labelStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w600),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    child: FlatButton(
                      onPressed: () async{
                        final String name = namecontroller.text;
                        final String desp = descontroller.text;
                        final String amount = amountcontroller.text;
                        final String quantity = quantcontroller.text;
                        var res =await Rent(_base64,name,amount,desp,quantity);
                        if(res==200)
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => success()),
                          );
                        }
                      },
                      padding: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(143, 148, 251, 1),
                            Color.fromRGBO(143, 148, 251, .6),
                          ]),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          constraints: BoxConstraints(
                              minHeight: 50, maxWidth: double.infinity),
                          child: Text(
                            "Rent Now!",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

