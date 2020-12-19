
import 'package:ieeecrop/Weahter_API/resources/config/application_colors.dart';
import 'package:ieeecrop/Weahter_API/ui/widget/weather_main_widget.dart';
import 'package:ieeecrop/Weahter_API/ui/widget/widget_helper.dart';
import 'package:ieeecrop/Weahter_API/utils/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ieeecrop/second_screen.dart';


class WeatherMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: <Widget>[
            Container(
                key: Key("weather_main_screen_container"),
                decoration: BoxDecoration(
                    gradient: WidgetHelper.buildGradient(
                        ApplicationColors.nightStartColor,
                        ApplicationColors.nightEndColor)),
                child: WeatherMainWidget()),
          ],
        )
    );

  }
}