import 'package:ieeecrop/Weahter_API/blocs/application_bloc.dart';
import 'package:ieeecrop/Weahter_API/models/internal/chart_data.dart';
import 'package:ieeecrop/Weahter_API/models/internal/point.dart';
import 'package:ieeecrop/Weahter_API/models/internal/weather_forecast_holder.dart';
import 'package:ieeecrop/Weahter_API/resources/config/assets.dart';
import 'package:ieeecrop/Weahter_API/resources/weather_helper.dart';
import 'package:ieeecrop/Weahter_API/ui/screen/base/weather_forecast_base_page.dart';
import 'package:ieeecrop/Weahter_API/ui/widget/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WeatherForecastWindPage extends WeatherForecastBasePage {
  WeatherForecastWindPage(
      WeatherForecastHolder holder, double width, double height)
      : super(holder: holder, width: width, height: height);

  @override
  Row getBottomRowWidget(BuildContext context) {
    List<Widget> rowElements = new List();
    List<Point> points = getChartData().points;
    if (points.length > 2) {
      double padding = points[1].x - points[0].x - 30;
      for (String direction in holder.getWindDirectionList()) {
        rowElements.add(SizedBox(
            width: 30,
            child: Center(
                child: Text(direction,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(fontSize: 12, color: Colors.white)))));
        rowElements.add(WidgetHelper.buildPadding(left: padding));
      }
      rowElements.removeLast();
    }
    return Row(
        key: Key("weather_forecast_wind_page_bottom_row"),
        mainAxisAlignment: MainAxisAlignment.center,
        children: rowElements);
  }

  @override
  ChartData getChartData() {
    return super.holder.setupChartData(ChartDataType.wind, width, height);
  }

  @override
  String getIcon() {
    return Assets.iconWind;
  }

  @override
  RichText getPageSubtitleWidget(BuildContext context) {

    var minWind = holder.minWind;
    var maxWind = holder.maxWind;
    if (applicationBloc.isMetricUnits()){
      minWind = WeatherHelper.convertMetersPerSecondToKilometersPerHour(minWind);
      maxWind = WeatherHelper.convertMetersPerSecondToKilometersPerHour(maxWind);
    } else {
      minWind = WeatherHelper.convertMetersPerSecondToMilesPerHour(minWind);
      maxWind = WeatherHelper.convertMetersPerSecondToMilesPerHour(maxWind);
    }

    return RichText(
        key: Key("weather_forecast_wind_page_subtitle"),
        textDirection: TextDirection.ltr,
        text: TextSpan(children: [
          TextSpan(text: 'min: ', style: TextStyle(fontSize: 12, color: Colors.white)),
          TextSpan(
              text: WeatherHelper.formatWind(minWind),
              style: TextStyle(fontSize: 20, color: Colors.white)),
          TextSpan(text: '   max: ', style: TextStyle(fontSize: 12, color: Colors.white)),
          TextSpan(
              text: WeatherHelper.formatWind(maxWind),
              style: TextStyle(fontSize: 20, color: Colors.white))
        ]));
  }

  @override
  String getTitleText(BuildContext context) {
    return 'Wind';
  }
}
