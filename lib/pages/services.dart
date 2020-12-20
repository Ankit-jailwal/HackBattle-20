import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ieeecrop/Language/translation/global_translation.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:ieeecrop/bloc/drawer_bloc.dart';
import 'package:ieeecrop/main.dart';
import 'package:ieeecrop/second_screen.dart';
import 'package:ieeecrop/pages/Sell_now.dart';
import 'package:ieeecrop/pages/Rent_now.dart';
import 'package:ieeecrop/services/authentication-service.dart';

import '../Functions_and_route.dart';


class service extends StatelessWidget with DrawerStates{
  Items item1 = new Items(
    title: "Schemes",
    subtitle: "",
    img: "assets/offer.png",
    page:"sch",);

  Items item2 = new Items(
    title: "Agencies",
    subtitle: "",
    img: "assets/agency.png",
    page:"agen",
  );


  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2];
    return Stack(
      children: [
        SafeArea(
          child: Scaffold(
            body: Center(
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  Container(height:100,child: Image.asset("assets/teamwork.png")),
                  SizedBox(height: 5,),
                  Text("Welcome to MAATI SERVICES",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 24,color: Colors.green.withOpacity(0.8),fontFamily: "Anton"),),
                  SizedBox(height: 50,),
                  Text("Do you want to see agencies or schemes?",style: TextStyle(fontSize:24,fontWeight: FontWeight.w700,fontFamily: "Saman",),textAlign: TextAlign.center,),
                  SizedBox(height: 20,),
                  Flexible(
                    child: GridView.count(
                        childAspectRatio: 1.0,
                        padding: EdgeInsets.only(left: 16, right: 16),
                        crossAxisCount: 2,
                        crossAxisSpacing: 18,
                        mainAxisSpacing: 18,
                        children: myList.map((data) {
                          return GestureDetector(
                            onTap: () async{
                              HapticFeedback.selectionClick();
                              print("tapped");
                              if(data.page=="sch") {
                                BlocProvider.of<DrawerBloc>(context).add(DrawerEvents
                                    .scheme);
                              }
                              else if(data.page=="agen") {
                                BlocProvider.of<DrawerBloc>(context).add(DrawerEvents
                                    .agen);
                              }

                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.tealAccent.withOpacity(0.6), borderRadius: BorderRadius.circular(10),),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    data.img,
                                    width: 42,
                                  ),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    data.title,
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList()),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.only(right: 15,bottom: 15),
            child: FloatingActionButton(
              tooltip: "Back button!",
              child: Icon(Icons.arrow_back_rounded),
              backgroundColor: Colors.amberAccent,
              onPressed: () {
                BlocProvider.of<DrawerBloc>(context).add(DrawerEvents
                    .menu);
              },
            ),
          ),
        ),
      ],
    );
  }
}
class Items {
  String title;
  String subtitle;
  String page;
  String img;
  Items({this.title, this.subtitle, this.page, this.img});
}

