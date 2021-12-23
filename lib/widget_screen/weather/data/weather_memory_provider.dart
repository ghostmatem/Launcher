import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'weather_item.dart';

  class WeatherMemoryProvider { 


  saveWeatherList(List<WeatherItem> weatherList, {String key = '_lastActually'}) async {   
      var result = WeatherItem.weatherListToJsonEncode(weatherList);
      SharedPreferences snapshot = await SharedPreferences.getInstance();
      snapshot.setString(key, result);  
  }

  Future<List<WeatherItem>?> getWeatherList({String key = '_lastActually'}) async {
    SharedPreferences snapshot = await SharedPreferences.getInstance();
    var json = snapshot.getString(key);
    var result =  WeatherItem.weatherListfromJsonDecode(json!);
    return result;
  }


  saveTimeLastRequest(DateTime timeLastRequest) async {
    SharedPreferences snapshot = await SharedPreferences.getInstance();
    snapshot.setString("_time", timeLastRequest.toString());
  }

  Future<String?> getTimeLastRequest() async {
    SharedPreferences snapshot = await SharedPreferences.getInstance();
    return snapshot.getString("_time");
  }

  saveWeatherCity(String city) async {
    SharedPreferences snapshot = await SharedPreferences.getInstance();
    snapshot.setString('_city', city);
  }

  Future<String?> getWeatherCity() async {
    SharedPreferences snapshot = await SharedPreferences.getInstance();
    return snapshot.getString('_city');
  }
}