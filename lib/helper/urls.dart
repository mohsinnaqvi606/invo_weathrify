import 'package:invo_weathrify/helper/global_variables.dart';

class Urls {
  static String baseURL = 'https://api.openweathermap.org/';
  static String getWeatherData =
      'data/2.5/weather?APPID=${GlobalVariables.weatherAppId}&units=metric&';
}
