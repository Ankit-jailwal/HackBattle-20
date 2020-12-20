import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ieeecrop/Language/translation/global_translation.dart';
import 'package:ieeecrop/Weahter_API/ui/screen/weather_main_screen.dart';
import 'package:ieeecrop/bloc/drawer_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class Main_menu extends StatefulWidget with DrawerStates{
  @override
  Main_menu_State createState() => new Main_menu_State();
}

class Main_menu_State extends State<Main_menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Home()
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  Items item1 = new Items(
    title: translations.text('menu.b1'),
    subtitle: "",
    img: "assets/images/camera.png",
    page:"main",  );

  Items item2 = new Items(
    title: translations.text('menu.b2'),
    subtitle: "",
    img: "assets/images/news.png",
    page:"news",
  );
  Items item3 = new Items(
    title: translations.text('menu.b7'),
    subtitle:"",
    img: "assets/shop.png",
    page:"shop",
  );
  Items item4 = new Items(
    title: translations.text('menu.b3'),
    subtitle: "",
    img: "assets/images/analysis.png",
    page:"analysis",
  );
  Items item5 = new Items(
    title: translations.text('menu.b8'),
    subtitle: "",
    img: "assets/teamwork.png",
    page:"ser",
  );

  Items item6 = new Items(
    title: translations.text('menu.b4'),
    subtitle: "",
    img: "assets/images/phone.png",
    page:"call",
  );
  Items item7 = new Items(
    title: translations.text('menu.b5'),
    subtitle: "",
    img: "assets/images/history.png",
    page:"history",
  );
  Items item8 = new Items(
    title: translations.text('menu.b6'),
    subtitle: "",
    img: "assets/images/contact.png",
    page:"contact",
  );


  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6,item7,item8];
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return GestureDetector(
              onTap: ()async{
                HapticFeedback.selectionClick();
                print("tapped");
                if(data.page=="main") {
                  BlocProvider.of<DrawerBloc>(context).add(DrawerEvents
                      .cam);
                }
                else if(data.page=="call")
                  {
                    launch("tel://1800-180-1551");
                  }
                else if(data.page=="analysis")
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WeatherMainScreen()),
                    );
                  }
                else if(data.page=="shop") {
                  BlocProvider.of<DrawerBloc>(context).add(DrawerEvents
                      .nav);
                }
                else if(data.page=="news") {
                  BlocProvider.of<DrawerBloc>(context).add(DrawerEvents
                      .news);
                }
                else if(data.page=="history")
                  {
                    BlocProvider.of<DrawerBloc>(context).add(DrawerEvents
                        .history);
                  }
                else if(data.page=="contact")
                {
                  BlocProvider.of<DrawerBloc>(context).add(DrawerEvents
                      .about);
                }
                else if(data.page=="ser")
                {
                  BlocProvider.of<DrawerBloc>(context).add(DrawerEvents
                      .ser);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.greenAccent.withOpacity(0.6), borderRadius: BorderRadius.circular(10),),
                child: Column(
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
                              color: Colors.black45,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      data.subtitle,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white38,
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
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

