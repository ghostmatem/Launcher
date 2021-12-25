import 'dart:convert';


class WeatherItem { 
  WeatherItem({required this.date, required this.city, required this.decription, 
  required this.temperature, required this.minTemp,
  required this.maxTemp, required this.humidity, 
  required this.wideSpeed, required this.iconCode, this.isMain = false, this.feelTemp = 0});

  
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
    return WeatherItem(
      date:         DateTime.fromMillisecondsSinceEpoch((json["date"] as int) * 1000),
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
        "date"        : date.microsecondsSinceEpoch ~/ 1000000,
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