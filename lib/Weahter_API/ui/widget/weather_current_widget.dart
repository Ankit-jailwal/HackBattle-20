import 'package:ieeecrop/Weahter_API/blocs/application_bloc.dart';
import 'package:ieeecrop/Weahter_API/models/remote/overall_weather_data.dart';
import 'package:ieeecrop/Weahter_API/models/remote/weather_response.dart';
import 'package:ieeecrop/Weahter_API/resources/weather_helper.dart';
import 'package:ieeecrop/Weahter_API/ui/screen/base/animated_state.dart';
import 'package:ieeecrop/Weahter_API/ui/widget/weather_forecast_thumbnail_list_widget.dart';
import 'package:ieeecrop/Weahter_API/ui/widget/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

class WeatherCurrentWidget extends StatefulWidget {
  final WeatherResponse weatherResponse;

  const WeatherCurrentWidget({Key key, this.weatherResponse}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WeatherCurrentWidgetState();
  }
}

class WeatherCurrentWidgetState extends AnimatedState<WeatherCurrentWidget> {
  final Logger log = new Logger('CurrentWeatherWidget');

  @override
  void initState() {
    super.initState();
    log.fine("Init weather widget state");
  }

  @override
  void dispose() {
    super.dispose();
    applicationBloc.currentWeatherWidgetAnimationState = false;
  }

  @override
  Widget build(BuildContext context) {
    return buildWeatherContainer(widget.weatherResponse);
  }

  Widget buildWeatherContainer(WeatherResponse response) {
    var currentTemperature = response.mainWeatherData.temp;
    if (!applicationBloc.isMetricUnits()) {
      currentTemperature =
          WeatherHelper.convertCelsiusToFahrenheit(currentTemperature);
    }

    return FadeTransition(
        opacity: setupAnimation(
            duration: 3000,
            noAnimation: !applicationBloc.currentWeatherWidgetAnimationState),
        child: Container(
            key: Key("weather_current_widget_container"),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                WidgetHelper.buildPadding(top: 30),
                Image.asset(
                  _getWeatherImage(response),
                  width: 100,
                  height: 100,
                ),
                Text(
                    WeatherHelper.formatTemperature(
                        temperature: currentTemperature,
                        metricUnits: applicationBloc.isMetricUnits()),
                    key: Key("weather_current_widget_temperature"),
                    textDirection: TextDirection.ltr,
                    style: TextStyle(fontSize: 60.0, color: Colors.white)),
                WidgetHelper.buildPadding(top: 30),
                Text(_getMaxMinTemperatureRow(response),
                    key: Key("weather_current_widget_min_max_temperature"),
                    textDirection: TextDirection.ltr,
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                WidgetHelper.buildPadding(top: 5),
               _getPressureAndHumidityRow(response),
                WidgetHelper.buildPadding(top: 20),
                WeatherForecastThumbnailListWidget(
                    system: response.system,
                    key: Key("weather_current_widget_thumbnail_list")),
                WidgetHelper.buildPadding(top: 20),
              ],
            ))));
  }

  String _getMaxMinTemperatureRow(WeatherResponse weatherResponse) {
    var maxTemperature = weatherResponse.mainWeatherData.tempMax;
    var minTemperature = weatherResponse.mainWeatherData.tempMin;
    if (!applicationBloc.isMetricUnits()) {
      maxTemperature = WeatherHelper.convertCelsiusToFahrenheit(maxTemperature);
      minTemperature = WeatherHelper.convertCelsiusToFahrenheit(minTemperature);
    }

    return "↑${WeatherHelper.formatTemperature(temperature: maxTemperature, metricUnits: applicationBloc.isMetricUnits())}" +
        " ↓${WeatherHelper.formatTemperature(temperature: minTemperature, metricUnits: applicationBloc.isMetricUnits())}";
  }

  Widget _getPressureAndHumidityRow(WeatherResponse weatherResponse) {
    return RichText(
        textDirection: TextDirection.ltr,
        key: Key("weather_current_widget_pressure_humidity"),
        text: TextSpan(children: [
          TextSpan(
              text: "Pressure: ",
              style: TextStyle(fontSize: 12, color: Colors.white)),
          TextSpan(
              text: WeatherHelper.formatPressure(weatherResponse.mainWeatherData.pressure),
              style: TextStyle(fontSize: 20, color: Colors.white)),
          TextSpan(
            text: "  ",
          ),
          TextSpan(
              text: "Humidity: ",
              style: TextStyle(fontSize: 12, color: Colors.white)),
          TextSpan(
              text: WeatherHelper.formatHumidity(weatherResponse.mainWeatherData.humidity),
              style: TextStyle(fontSize: 20, color: Colors.white))
        ]));
  }

  String _getWeatherImage(WeatherResponse weatherResponse) {
    OverallWeatherData overallWeatherData =
        weatherResponse.overallWeatherData[0];
    int code = overallWeatherData.id;
    return WeatherHelper.getWeatherIcon(code);
  }

  @override
  void onAnimatedValue(double value) {}
}
