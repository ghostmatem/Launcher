import 'dart:convert';
import 'dart:io';

import 'package:launch/widget_screen/weather/data/weather_item.dart';

// Решил сам написать под свою модель. Попрактиковаться так сказать))
class WeatherRequest {

  final HttpClient _html = HttpClient();
  final String _apiKey;
  static const String _current = 'weather';
  static const String _forecast = 'forecast';

  WeatherRequest(this._apiKey);

  Future<WeatherItem> getCurrentWeather(String city) async {
    var json = await _sendRequest(city, _current);
    return _currentFromJson(json);
  }

  Future<List<WeatherItem>> getForecastWeather(String city) async {
    var json = await _sendRequest(city, _forecast);
    return _forecastFromJson(json);
  }

  Future<Map<String, dynamic>> _sendRequest (String city, String tag) async {
    Uri url =  Uri.parse(
      'http://api.openweathermap.org/data/2.5/$tag?q=$city&units=metric&lang=ru&appid=$_apiKey');

    var request = await _html.getUrl(url);
    var response = await request.close();
    if (response.statusCode == 200) {
      var jsonStrList = await response.transform(utf8.decoder).toList();
      var json = jsonDecode(jsonStrList.join()) as Map<String, dynamic>;
      return json;
    }
    throw Exception('API не пришел на встречу подписчиков(');
  }

  static List<WeatherItem> _forecastFromJson(Map<String, dynamic> json) {
    var city = json['city']['name']as String;
    var result = (json['list'] as List<dynamic>)
    .map((e) => e as Map<String, dynamic>)
    .map((j) => _parseJson(j, city)).toList();
    return result;
  }

  static WeatherItem _currentFromJson(Map<String, dynamic> json) {
    return _parseJson(json, json['name'] as String, true);
  }


  static WeatherItem _parseJson(Map<String, dynamic> json, 
  String city, [bool isMain = false]) {

    var valueWind = json['wind']['speed'];
    var wind = valueWind is int ? valueWind : (valueWind as double).round();
    var weatherMap = (json['weather'] as List<dynamic>)[0] as  Map<String, dynamic>;
    var mainMap = json['main']as Map<String, dynamic>;

    return WeatherItem(
      date:           DateTime.fromMillisecondsSinceEpoch((json["dt"] as int) * 1000),
      city:           city,
      decription:     weatherMap['description'] as String, 
      iconCode:       weatherMap['icon'] as String,       
      temperature:   (mainMap['temp'] as double).round(),  
      minTemp:       (mainMap['temp_min'] as double).round(),
      maxTemp:       (mainMap['temp_max'] as double).round(),
      feelTemp:      (mainMap['feels_like'] as double).round(),
      humidity:       mainMap['humidity'] as int,
      wideSpeed:      wind,
      isMain:         isMain,
       );
  }
}