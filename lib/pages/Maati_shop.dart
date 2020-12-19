
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ieeecrop/bloc/drawer_bloc.dart';
import 'package:ieeecrop/config/config.dart';


final List<String> imgList = [
  'assets/images/offer.png',
  'assets/images/offer.png',
  'assets/images/offer.png',
  'assets/images/offer.png',
];
final List<String> img = [
  'assets/crop.png',
  'assets/crop.png',
  'assets/crop.png',
  'assets/crop.png',
  'assets/crop.png',
  'assets/crop.png',
  'assets/crop.png',
  'assets/crop.png',
  'assets/crop.png',
];
class maati_shop extends StatelessWidget with DrawerStates{
  Items item1 = new Items(
    title: "Seeds",
    subtitle: "",
    img: "assets/seed.png",
    page:"seed",  );

  Items item2 = new Items(
    title: "Fertilizers",
    subtitle: "",
    img: "assets/crop.png",
    page:"ferti",
  );
  Items item3 = new Items(
    title: "Tools",
    subtitle: "",
    img: "assets/tool.png",
    page:"tool",
  );
  Items item4 = new Items(
    title: "Pesticides",
    subtitle: "",
    img: "assets/pesticide.png",
    page:"pest",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4];
    return SingleChildScrollView(
      child: Column(
        children: [

      Column(
        children: [
          Padding(
            padding:
            EdgeInsets.symmetric(horizontal: 50),
            child:Text(
              "Shop by Categories",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.black
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFfff7e8),
                borderRadius: BorderRadius.circular(5),
              ),
              child: GridView.count(
                shrinkWrap: true,
                physics: new NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: myList.map((item) => GestureDetector(
                  onTap: () async{
                    if(item.page =="seed")
                    {BlocProvider.of<DrawerBloc>(context).add(DrawerEvents
                        .seed);}
                    else if(item.page =="ferti")
                    {BlocProvider.of<DrawerBloc>(context).add(DrawerEvents
                        .ferti);}
                    else if(item.page =="pest")
                    {BlocProvider.of<DrawerBloc>(context).add(DrawerEvents
                        .pest);}
                    else if(item.page =="tool")
                    {BlocProvider.of<DrawerBloc>(context).add(DrawerEvents
                        .tool);}
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top:10,left: 7,right: 7,bottom: 5),
                    child: Container(
                      padding: EdgeInsets.only(left: 5,right: 5,top: 8, bottom: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFFffefaf),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 110,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: AssetImage(item.img),

                                )
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            height: 35,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white
                            ),
                            child: Center(child: Text(item.title,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),textAlign: TextAlign.center,)),
                          )
                        ],
                      ),
                    ),
                  ),
                )).toList(),
              ),
            ),
          )
        ],
      ),
          SizedBox(height: 18),
        ],
      ),
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