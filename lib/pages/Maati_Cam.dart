import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:ieeecrop/Language/translation/global_translation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ieeecrop/bloc/drawer_bloc.dart';
import 'package:ieeecrop/Functions_and_route.dart';


class maaticam extends StatefulWidget with DrawerStates {
  @override
  _maaticamState createState() => _maaticamState();
}

class _maaticamState extends State<maaticam> {
  final maxLines = 5;
  File _image;
  File path;
  String _base64;

  Future get_image() async {
    final img = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = img;
      List<int> imageBytes = _image.readAsBytesSync();
      String imageB64 = base64Encode(imageBytes);
      //print(imageB64);
      _base64 = imageB64;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  FlatButton(
                    onPressed: get_image,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: _image == null
                          ? Image.asset(
                              'assets/images/cam.jpg',
                            )
                          : Image.file(_image),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    child: FlatButton(
                      onPressed: () {},
                      padding: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: FlatButton(
                          onPressed: ()  {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => output(_base64)),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            constraints: BoxConstraints(
                                minHeight: 50, maxWidth: double.infinity),
                            child: Text(
                              translations.text('cam.b1'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
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

class output extends StatelessWidget with DrawerStates {
  var base64;
  output(this.base64);
  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder(
        future: crop_api_call(base64),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(), //Circular progress indicator
              ),
            );
          }
          else if (snapshot.data!= null) {
            final data=snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: Text(translations.text('output.head')),
              ),
              body: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        Card(
                          //                           <-- Card widget
                          child: ListTile(
                              subtitle: Text(data['Data']['Crops'] ?? ""),
                              title: Text(translations.text('output.o1')),
                              trailing:Image.asset("assets/crop.png")
                          ),
                        ),
                        Card(
                          //                           <-- Card widget
                          child: ListTile(
                              subtitle: Text(data['Data']['Fertilisers required'] ?? ""),
                              title: Text(translations.text('output.o2')
                              ),
                              trailing: Image.asset("assets/fertilizer.png")
                          ),
                        ),
                        Card(
                          //                           <-- Card widget
                          child: ListTile(
                              subtitle: Text(data['Data']['Cost of cultivation'] ?? ""),
                              title: Text(translations.text('output.o3')),
                              trailing: Image.asset("assets/cul.png")
                          ),
                        ),
                        Card(
                          //                           <-- Card widget
                          child: ListTile(
                              subtitle: Text(data['Data']['Expected revenues'] ?? ""),
                              title: Text(translations.text('output.o4')),
                              trailing: Image.asset("assets/revenue.png")
                          ),
                        ),
                        Card(
                          //                           <-- Card widget
                          child: ListTile(
                              subtitle:
                              Text(data['Data']['Quantity of seeds per hectare'] ?? ""),
                              title: Text(translations.text('output.o5')),
                              trailing: Image.asset("assets/seed.png")
                          ),
                        ),
                        Card(
                          //                           <-- Card widget
                          child: ListTile(
                              subtitle: Text(data['Data']['Duration of cultivation'] ?? ""),
                              title: Text(translations.text('output.o6')),
                              trailing: Image.asset("assets/time.png")
                          ),
                        ),
                        Card(
                          //                           <-- Card widget
                          child: ListTile(
                              subtitle: Text(data['Data']['Demand of crop'] ?? ""),
                              title: Text(translations.text('output.o7')),
                              trailing: Image.asset("assets/demand.png")
                          ),
                        ),
                        Card(
                          //                           <-- Card widget
                          child: ListTile(
                              subtitle: Text(data['Data']['Crops for mixed cropping'] ?? ""),
                              title: Text(translations.text('output.o8')),
                              trailing:Image.asset("assets/mix.png")
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
          else {
            return  NetworkGiffyDialog(
              image: Image.network(
                "https://media.giphy.com/media/l4pLY0zySvluEvr0c/giphy.gif",
                fit: BoxFit.cover,
              ),
              entryAnimation: EntryAnimation.TOP_LEFT,
              title: Text(
                translations.text('login.er'),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22.0, fontWeight: FontWeight.w600),
              ),
              description: Text(
                translations.text('login.des'),
                textAlign: TextAlign.center,
              ),
              onlyOkButton: true,
              onOkButtonPressed: (){
                Navigator.pop(context);
              },
            );
          }
        },

      );
  }
}
