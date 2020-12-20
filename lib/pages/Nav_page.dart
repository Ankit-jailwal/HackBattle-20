import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ieeecrop/bloc/drawer_bloc.dart';
import 'package:ieeecrop/pages/Sell_now.dart';
import 'package:ieeecrop/pages/Rent_now.dart';


class nav_page extends StatelessWidget with DrawerStates{
  Items item1 = new Items(
    title: "Buy",
    subtitle: "",
    img: "assets/buy.png",
    page:"buy",);

  Items item2 = new Items(
    title: "Sell",
    subtitle: "",
    img: "assets/commission.png",
    page:"sell",
  );
  Items item3 = new Items(
    title: "rent",
    subtitle: "",
    img: "assets/rent.png",
    page:"rent",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3];
    return Stack(
      children: [
        SafeArea(
          child: Scaffold(
            body: Center(
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  Container(height:100,child: Image.asset("assets/shop.png")),
                  Text("Welcome to MAATI SHOP",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 24,color: Colors.green.withOpacity(0.8),fontFamily: "Anton"),),
                  SizedBox(height: 50,),
                  Text("Do you want to Shop or Sell?",style: TextStyle(fontSize:24,fontWeight: FontWeight.w700,fontFamily: "Saman"),),
                  SizedBox(height: 20,),
                  Flexible(
                    child: GridView.count(
                        childAspectRatio: 1.0,
                        padding: EdgeInsets.only(left: 16, right: 16),
                        crossAxisCount: 3,
                        crossAxisSpacing: 18,
                        mainAxisSpacing: 18,
                        children: myList.map((data) {
                          return GestureDetector(
                            onTap: () async{
                              HapticFeedback.selectionClick();
                              print("tapped");
                              if(data.page=="buy") {
                                BlocProvider.of<DrawerBloc>(context).add(DrawerEvents
                                    .shop);
                              }
                              else if(data.page=="sell") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Sell_now()),
                                );
                              }
                              else if(data.page=="rent")
                              {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Rent_now()),
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.greenAccent.withOpacity(0.6), borderRadius: BorderRadius.circular(10),),
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
                                            color: Colors.black45,
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

