import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:ieeecrop/Functions_and_route.dart';
import 'package:ieeecrop/Language/translation/global_translation.dart';
import 'package:ieeecrop/bloc/drawer_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ieeecrop/config/config.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class agencies_screen extends StatelessWidget with DrawerStates {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
          future: getagencies(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(), //Circular progress indicator
              );
            } else if (snapshot.data != null) {
              //Storing token in local storage
              return Stack(
                children: [
                  Column(
                    children: <Widget>[
                      Expanded(
                          child: ListView.builder(
                              itemCount: snapshot
                                  .data['Data'].length, //list view declaration
                              padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: (){
                                    openFeed(snapshot.data['Data'][index]
                                    ['Link']);
                                  },
                                  child: Card(
                                    child: ListTile(
                                      leading: Image.network(snapshot.data['Data'][index]
                                      ['Image']),
                                      title: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("State:  ${snapshot.data['Data'][index]['States']}"),
                                          Text("APMC: ${snapshot.data['Data'][index]['APMC']}"),
                                          Text("Address: ${snapshot.data['Data'][index]['Address']}"),
                                          Text("Contact: ${snapshot.data['Data'][index]['Contact']}"),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 15, bottom: 15),
                      child: FloatingActionButton(
                        tooltip: "Back button!",
                        child: Icon(Icons.arrow_back_outlined),
                        backgroundColor: Colors.amberAccent,
                        onPressed: () {
                          BlocProvider.of<DrawerBloc>(context)
                              .add(DrawerEvents.ser);
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return NetworkGiffyDialog(
                image: Image.network(
                  "https://media.giphy.com/media/l4pLY0zySvluEvr0c/giphy.gif",
                  fit: BoxFit.cover,
                ),
                entryAnimation: EntryAnimation.TOP_LEFT,
                title: Text(
                  translations.text('login.er'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                ),
                description: Text(
                  translations.text('login.des'),
                  textAlign: TextAlign.center,
                ),
                onlyOkButton: true,
                onOkButtonPressed: () {
                  Navigator.pop(context);
                },
              );
            }
          },
        ));
  }
}
Future<void> openFeed(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: true,
      forceWebView: false,
    );
    return;
  }
}