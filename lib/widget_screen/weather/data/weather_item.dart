import 'package:weather/weather.dart';
import 'dart:convert';


class WeatherItem {
  WeatherItem(Weather weather, {this.isMain = false}) {
    date = weather.date!;
    city = weather.areaName!;
    decription = weather.weatherDescription!;
    temperature = (weather.temperature!.celsius)!.round();
    minTemp = (weather.tempMin!.celsius)!.round();
    maxTemp = (weather.tempMax!.celsius)!.round();
    humidity = weather.humidity!.round();
    wideSpeed = weather.windSpeed!.round();
    iconCode = weather.weatherIcon.toString();
    feelTemp = weather.tempFeelsLike!.celsius!.round();
  }
  WeatherItem.build({required this.date, required this.city, required this.decription, 
  required this.temperature, required this.minTemp,
  required this.maxTemp, required this.humidity, 
  required this.wideSpeed, required this.iconCode, this.isMain = false, this.feelTemp = 0});

  WeatherItem.fromStringList(List<String> weatherList) {
    date = DateTime.parse(weatherList[0]);
    city = weatherList[1];
    decription = weatherList[2];
    temperature = int.parse(weatherList[3]);
    minTemp = int.parse(weatherList[4]);
    maxTemp = int.parse(weatherList[5]);
    humidity = int.parse(weatherList[6]);
    wideSpeed = int.parse(weatherList[7]);
    iconCode = weatherList[8];
    isMain = int.parse(weatherList[9]) == 0 ? false : true;
    feelTemp = int.parse(weatherList[10]);
  }
  
  
  late DateTime date;
  late String city;
  late String decription;
  late int temperature;
  late int minTemp;
  late int maxTemp;
  late int feelTemp;
  late int humidity;
  late int wideSpeed;
  late String iconCode;
  late bool isMain;

factory WeatherItem.fromJson(Map<String, dynamic> json) {
    return WeatherItem.build(
      date:         DateTime.parse(json["date"] as String),
      city:         json["city"]         as String,
      decription:   json["decription"]   as String,
      temperature:  json["temperature"]  as int,
      minTemp:      json["minTemp"]      as int,
      maxTemp:      json["maxTemp"]      as int,
      humidity:     json["humidity"]     as int,
      wideSpeed:    json["wideSpeed"]    as int,
      iconCode:     json["iconCode"]     as String,
      isMain:       json["isMain"]       as bool,
      feelTemp:     json["feelTemp"]     as int,
      );
  }

    Map<String, dynamic> toJson() {
      return <String, dynamic> {
        "date"        : date.toString(),
        "city"        : city,
        "decription"  : decription,
        "temperature" : temperature,
        "minTemp"     : minTemp,
        "maxTemp"     : maxTemp,
        "humidity"    : humidity,
        "wideSpeed"   : wideSpeed,
        "iconCode"    : iconCode,
        "isMain"      : isMain,
        "feelTemp"    : feelTemp,      
      };
    }

    static WeatherItem fromJsonDecode(String strJson) {
      var json = jsonDecode(strJson) as Map<String, dynamic>;
      return WeatherItem.fromJson(json);
    }

    static String toJsonEncode(WeatherItem weather) {
      var json = weather.toJson();
      return jsonEncode(json);
    }

    static List<WeatherItem> weatherListfromJsonDecode(String strJson) {
      var json = jsonDecode(strJson) as List<dynamic>;
      var weathers = json.map((weather) 
      => WeatherItem.fromJson(weather as Map<String, dynamic>)).toList();
      return weathers;
    }

    static String weatherListToJsonEncode(List<WeatherItem> weathers) {
      var jsonMap = weathers.map((weather) => weather.toJson()).toList();
      return jsonEncode(jsonMap);
    }

    String toJsonEncodeThis() => WeatherItem.toJsonEncode(this);
}