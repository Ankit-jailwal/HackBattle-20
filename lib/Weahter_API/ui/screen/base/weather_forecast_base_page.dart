import 'package:ieeecrop/Weahter_API/models/internal/chart_data.dart';
import 'package:ieeecrop/Weahter_API/models/internal/weather_forecast_holder.dart';
import 'package:ieeecrop/Weahter_API/ui/widget/chart_widget.dart';
import 'package:ieeecrop/Weahter_API/ui/widget/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class WeatherForecastBasePage extends StatelessWidget {
  final WeatherForecastHolder holder;
  final double width;
  final double height;

  const WeatherForecastBasePage(
      {Key key,
      @required this.holder,
      @required this.width,
      @required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChartData chartData = getChartData();
    return Center(
        child: Column(children: [
      getPageIconWidget(),
      getPageTitleWidget(context),
      WidgetHelper.buildPadding(top: 20),
      getPageSubtitleWidget(context),
      WidgetHelper.buildPadding(top: 40),
      ChartWidget(
          key: Key("weather_forecast_base_page_chart"), chartData: chartData),
      WidgetHelper.buildPadding(top: 10),
      getBottomRowWidget(context)
    ]));
  }

  Image getPageIconWidget() {
    return Image.asset(getIcon(),
        key: Key("weather_forecast_base_page_icon"), width: 100, height: 100);
  }

  Widget getPageTitleWidget(BuildContext context) {
    return Text(getTitleText(context),
        key: Key("weather_forecast_base_page_title"),
        textDirection: TextDirection.ltr,
        style: TextStyle(fontSize: 20, color: Colors.white));
  }

  String getIcon();

  String getTitleText(BuildContext context);

  RichText getPageSubtitleWidget(BuildContext context);

  Widget getBottomRowWidget(BuildContext context);

  ChartData getChartData();
}
