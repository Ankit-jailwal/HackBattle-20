import 'package:ieeecrop/Weahter_API/models/internal/chart_data.dart';
import 'package:ieeecrop/Weahter_API/models/internal/weather_forecast_holder.dart';
import 'package:ieeecrop/Weahter_API/resources/config/assets.dart';
import 'package:ieeecrop/Weahter_API/resources/weather_helper.dart';
import 'package:ieeecrop/Weahter_API/ui/screen/base/weather_forecast_base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WeatherForecastPressurePage extends WeatherForecastBasePage {
  WeatherForecastPressurePage(
      WeatherForecastHolder holder, double width, double height)
      : super(holder: holder, width: width, height: height);

  @override
  Row getBottomRowWidget(BuildContext context) {
    return Row(
      key: Key("weather_forecast_pressure_page_bottom_row"),
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  @override
  ChartData getChartData() {
    return super.holder.setupChartData(ChartDataType.pressure, width, height);
  }

  @override
  String getIcon() {
    return Assets.iconBarometer;
  }

  @override
  RichText getPageSubtitleWidget(BuildContext context) {
    return RichText(
        key: Key("weather_forecast_pressure_page_subtitle"),
        textDirection: TextDirection.ltr,
        text: TextSpan(children: [
          TextSpan(text: 'min: ', style: TextStyle(fontSize: 12, color: Colors.white)),
          TextSpan(
              text: WeatherHelper.formatPressure(holder.minPressure),
              style: TextStyle(fontSize: 20, color: Colors.white)),
          TextSpan(text: '   max: ', style: TextStyle(fontSize: 12, color: Colors.white)),
          TextSpan(
              text: WeatherHelper.formatPressure(holder.maxPressure),
              style: TextStyle(fontSize: 20, color: Colors.white))
        ]));
  }

  @override
  String getTitleText(BuildContext context) {
    return 'Pressure';
  }
}
