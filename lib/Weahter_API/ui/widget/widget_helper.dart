import 'package:ieeecrop/Weahter_API/models/internal/application_error.dart';
import 'package:ieeecrop/Weahter_API/resources/config/application_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WidgetHelper {
  static Padding buildPadding(
      {double left = 0, double top = 0, double right = 0, double bottom = 0}) {
    return Padding(
        padding: buildEdgeInsets(
            left: left, top: top, right: right, bottom: bottom));
  }

  static EdgeInsets buildEdgeInsets(
      {double left = 0, double top = 0, double right = 0, double bottom = 0}) {
    return EdgeInsets.fromLTRB(left, top, right, bottom);
  }

  static LinearGradient buildGradient(Color startColor, Color endColor) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.2, 0.99],
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        startColor,
        endColor,
      ],
    );
  }

  static Widget buildProgressIndicator() {
    return Center(
        key: Key("progress_indicator"),
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
        ));
  }

  static Widget buildErrorWidget(
      {BuildContext context,
      ApplicationError applicationError,
      VoidCallback voidCallback,
      bool withRetryButton}) {
    String errorText = "";
    if (applicationError == ApplicationError.locationNotSelectedError) {
      errorText = "Error location not found!";
    } else if (applicationError == ApplicationError.connectionError) {
      errorText = "Please check your internet connection!";
    } else if (applicationError == ApplicationError.apiError) {
      errorText = "Internal server error!";
    } else {
      errorText = "Something went wrong!";
    }
    List<Widget> widgets = new List();
    widgets.add(Text(
      errorText,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    ));
    if (withRetryButton) {
      widgets.add(FlatButton(
        child: Text("Retry!",
            style: TextStyle(fontSize: 20, color: Colors.white)),
        onPressed: voidCallback,
      ));
    }

    return Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
            key: Key("error_widget"),
            child: SizedBox(
                width: 250,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widgets))));
  }

static LinearGradient buildGradientBasedOnDayCycle(int sunrise, int sunset) {
    DateTime now = new DateTime.now();
    int nowMs = now.millisecondsSinceEpoch;
    int sunriseMs = sunrise * 1000;
    int sunsetMs = sunset * 1000;

    if (nowMs < sunriseMs) {
      int lastMidnight = new DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
      return getNightGradient((sunriseMs - nowMs) / (sunriseMs - lastMidnight));
    } else if (nowMs > sunsetMs) {
      int nextMidnight = new DateTime(now.year, now.month, now.day + 1).millisecondsSinceEpoch;
      return getNightGradient((nowMs - sunsetMs) / (nextMidnight - sunsetMs));
    } else {
      return getDayGradient((nowMs - sunriseMs) / (sunsetMs - sunriseMs));
    }
  }

  static LinearGradient getNightGradient(double percentage) {
    if (percentage <= 0.1) {
        return buildGradient(ApplicationColors.dawnDuskStartColor, ApplicationColors.dawnDuskEndColor);
      } else if (percentage <= 0.2) {
        return buildGradient(ApplicationColors.twilightStartColor, ApplicationColors.twilightEndColor);
      } else if (percentage <= 0.6) {
        return buildGradient(ApplicationColors.nightStartColor, ApplicationColors.nightEndColor);
      } else {
        return buildGradient(ApplicationColors.midnightStartColor, ApplicationColors.midnightEndColor);
      }
  }

  static LinearGradient getDayGradient(double percentage) {
    if (percentage <= 0.1 || percentage >= 0.9) {
      return buildGradient(ApplicationColors.dawnDuskStartColor, ApplicationColors.dawnDuskEndColor);
    } else if (percentage <= 0.2 || percentage >= 0.8) {
      return buildGradient(ApplicationColors.morningEveStartColor, ApplicationColors.morningEveEndColor);
    } else if (percentage <= 0.4 || percentage >= 0.6) {
      return buildGradient(ApplicationColors.dayStartColor, ApplicationColors.dayEndColor);
    } else {
      return buildGradient(ApplicationColors.middayStartColor, ApplicationColors.middayEndColor);
    }
  }

  static LinearGradient getGradient({sunriseTime = 0, sunsetTime = 0}) {
    if (sunriseTime == 0 && sunsetTime == 0) {
      return buildGradient(ApplicationColors.midnightStartColor, ApplicationColors.midnightEndColor);
    } else {
      return buildGradientBasedOnDayCycle(sunriseTime, sunsetTime);
    }
  }
}
