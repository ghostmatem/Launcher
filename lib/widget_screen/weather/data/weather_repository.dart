
// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:launch/widget_screen/weather/data/weather_api_provider.dart';
import 'package:launch/widget_screen/weather/data/weather_memory_provider.dart';
import 'weather_item.dart';

class WeatherRepository {
  WeatherRepository(String apiKey, {Duration? duration}) {
    _apiProvider = WeatherAPIProvider(apiKey, duration?.inMinutes ?? 30, _memoryProvider); 
  }
  List<WeatherItem> get Weathers => _weathers;

  bool get WeatherExist => _weatherListHasData;

  String get City => _city;

  set City (newCity) {
    _city = newCity;
    _memoryProvider.saveWeatherCity(_city);
  }

  bool get CityUndefined => _city == '';

  bool get apiClosed => !_apiProvider.apiIsOpen;

  List<WeatherItem> _weathers = [];
  String _city = '';

  late final WeatherAPIProvider _apiProvider; 

  final WeatherMemoryProvider _memoryProvider = WeatherMemoryProvider();

  openApi() => _apiProvider.resetAPICallback();

  tryInitTimeLastRequest() async {
    if (_apiProvider.timeLastRequestIsNull) {
      await _apiProvider.initTimeLastRequest();
    }
  }

  tryInitCity() async {
    if (CityUndefined) {
      var savedCity = await _memoryProvider.getWeatherCity();
      if (savedCity == '' || savedCity == null) {
        throw Exception('City isn\'t definded');
      }
      _city = savedCity;
    }
  }

  Future<List<WeatherItem>> getWeatherFromAPI(String cityName) async{
     List<WeatherItem> result = [];
     var oneDay = await _getWeatherOnDayFromAPI(cityName: cityName);
     result.add(oneDay!);
     var threeDay = await _getWeatherOnThreeDaysFromAPI(cityName: cityName);
     result.addAll(threeDay);
     _weathers = result;
     _memoryProvider.saveWeatherList(result);
     return result;
  }

  Future<List<WeatherItem>> getWeatherFromMemory() async{
     var threeDay = await _getWeatherFromMemory();
     return threeDay;
  }



  // Методы для обработки данных 



  static const List<String> customDayOfWeek= 
  ['Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота', 'Воскресенье',];

  get _weatherListHasData => 
  (_weathers.isNotEmpty);

  //получить данные из API в виде Future<WeatherItem>
  Future<WeatherItem?> _getWeatherOnDayFromAPI({String cityName = 'Yaroslavl'}) async {
    var snapshot = await _apiProvider.getWeatherInfoOnDay(cityName: cityName);
    print('API1');
    return snapshot;
  }

   Future<List<WeatherItem>> _getWeatherOnThreeDaysFromAPI({String cityName = 'Yaroslavl'}) async {
    var snapshot = await _apiProvider.getWeatherInfoOnThreeDay(cityName: cityName);
    var result = await _getStreamWeatherItems(snapshot).toList();
    print('API2');
    return result;
  }

  Future<List<WeatherItem>> _getWeatherFromMemory() async {
     if (!_weatherListHasData) {
        var snapshot = await _memoryProvider.getWeatherList();
        print('mem2 request');
        if (snapshot == null) throw Exception('Don\'t has data');
        _weathers = snapshot;
     }
    return _weathers;
  }

  Stream<WeatherItem> _getStreamWeatherItems(List<WeatherItem> snapshot) async* {
    var valueToSkip = (DateTime.now().weekday % 7) + 1;
    List<WeatherItem> buffer = [];
    int lenght = snapshot.length;
    for (int i = 0; i < lenght; i++) {
      int dayOfWeek = snapshot[i].date.weekday;
      int dayOfWeekNext = i < lenght - 1 ? 
      snapshot[i + 1].date.weekday : valueToSkip + 1;
    
      if (dayOfWeek == valueToSkip) {
        buffer.add(snapshot[i]);
        if (dayOfWeekNext != valueToSkip) {
         var result = _getAverangeWeather(buffer);
         yield result;
         buffer.clear();      
         valueToSkip = (valueToSkip % 7) + 1;
        }
      } 
    }
  }

  WeatherItem _getAverangeWeather(List<WeatherItem> data) {
    int length = data.length;
    int mIndex = _getModeWeatherIndex(data);

    int wideSpeedSum = 0;
    int tempSum = 0;
    int tempMin = 200;
    int tempMax = -200;
    for (var item in data) {
      var temp = item.temperature;
      tempSum += temp;
      wideSpeedSum += item.wideSpeed;
      tempMin = temp < tempMin ? temp : tempMin;
      tempMax = temp > tempMax ? temp :  tempMax;
    }
    return WeatherItem
    (date: data[length~/2].date, 
    city: customDayOfWeek[data[0].date.weekday - 1], 
    decription: data[mIndex].decription, 
    temperature: (tempSum/length).round(), 
    minTemp: tempMin, 
    maxTemp: tempMax, 
    humidity: data[0].humidity, 
    wideSpeed: (wideSpeedSum/length).round(), 
    iconCode: data[mIndex].iconCode);
  }

  int _getModeWeatherIndex(List<WeatherItem> data) {
    int index = 0;
    Map<String, int> map = <String, int>{};
    for (var d in data) {
      var key = d.decription;
      if (!map.containsKey(key)) {
        map[key] = 0;
      }
      map[key] = map[key] !+ 1;
    }
    int maxV = 0;
    int maxI = 0;
    for (var k in map.keys) {
      if (map[k] !> maxV) {
        maxV = map[k]!;
        maxI = index;
      }
      index++;
    }
    return maxI;
  }
}

