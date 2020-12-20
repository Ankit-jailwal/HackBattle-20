import 'package:flutter/material.dart';
import 'package:ieeecrop/Language/translation/global_translation.dart';
import 'package:ieeecrop/bloc/drawer_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';

class history_screen extends StatelessWidget with DrawerStates{
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(height: 10,),
            Text(translations.text('history.p1'),
            style: TextStyle(
              fontSize: 20,
              color: Colors.black87,
              fontWeight: FontWeight.w800,
              fontFamily: "Roberto"
            ),
            ),
            SizedBox(height: 40,),
            Container(
              height: 200,
              child: Image.asset(
                  "assets/images/his.png"),
            ),
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
                    .add(DrawerEvents.menu);
              },
            ),
          ),
        ),
      ],
    );
  }
}


