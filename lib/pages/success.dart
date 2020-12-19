import 'package:flutter/material.dart';
import 'package:ieeecrop/pages/Nav_page.dart';

class success extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          SizedBox(height: 200,),
          Center(child: Container(height:150,child: Image.asset("assets/tick.png"))),
          SizedBox(height: 30,),
          Text("Item added successfully",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 25,color: Colors.black87,fontFamily: "Anton"),),
          SizedBox(height: 10,),
          Container(
            height: 50,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.green.withOpacity(0.6),
            ),
            child: FlatButton(
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => nav_page()));
              },
              child: Center(
                child: Text(
                  "Continue Exploring",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
