// ignore_for_file: file_names

import 'package:launch/widget_screen/weather/data/weather_memory_provider.dart';
import 'package:weather/weather.dart';
import 'dart:async';

class WeatherAPIProvider {
  WeatherAPIProvider(String apiKey, int apiDelayOnMinutes, 
  WeatherMemoryProvider weatherMemoryProvider) {
    _weatherAPI = WeatherFactory(apiKey, language: Language.RUSSIAN);
    _memoryProvider = weatherMemoryProvider;
    _apiDelay = apiDelayOnMinutes;
  }

  late WeatherFactory _weatherAPI;
  late final WeatherMemoryProvider _memoryProvider;

  static int _counterRequestApiOneDay = 0;
  static int _counterRequestApiThreeDay = 0;

  static int _requestApiLimit = 1;
  
  DateTime? _timeLastRequest;
  late final _apiDelay;

  Future<Weather> getWeatherInfoOnDay({String cityName = 'Yaroslavl'}) async {
    await checkClosedAPI(closedForOneDayRequest);
    var weatherInfo = await _weatherAPI.currentWeatherByCityName(cityName);
    _counterRequestApiOneDay++;
    postCheckClosedAPI();
    return weatherInfo;
  }

  Future<List<Weather>> getWeatherInfoOnThreeDay({String cityName = 'Yaroslavl'}) async {
    await checkClosedAPI(closedForThreeDayRequest);
    var weatherInfo = await _weatherAPI.fiveDayForecastByCityName(cityName);
    _counterRequestApiThreeDay++;
    postCheckClosedAPI();
    return weatherInfo;
  }

  get apiIsOpen => DateTime.now().difference(_timeLastRequest!).inMinutes > _apiDelay; 
  get closedForOneDayRequest => _counterRequestApiOneDay >= _requestApiLimit;
  get closedForThreeDayRequest => _counterRequestApiThreeDay >= _requestApiLimit;

  set timeLastRequest (DateTime value){
    _timeLastRequest = value;
    _memoryProvider.saveTimeLastRequest(value);
  }
  get timeLastRequestIsNull => _timeLastRequest == null;

  Future<DateTime> initTimeLastRequest() async {
    var snapshot = await _memoryProvider.getTimeLastRequest();
    if (snapshot != null) {
      _timeLastRequest = DateTime.parse(snapshot);
    } 
    else {
      _timeLastRequest = DateTime.now().add(const Duration(hours: -7));
    }
    return _timeLastRequest!;
  }

  updateTimeOfLastRequest() {
    timeLastRequest = DateTime.now();
    _counterRequestApiOneDay = 0;
    _counterRequestApiThreeDay = 0;
  }

  closeApi() => updateTimeOfLastRequest();

  resetAPICallback() {
    timeLastRequest = DateTime.now().add(const Duration(hours: -7));
    _counterRequestApiOneDay = 0;
    _counterRequestApiThreeDay = 0;
  }

  checkClosedAPI (bool closedForThis) {
      if (closedForThis || !apiIsOpen) {
        postCheckClosedAPI();
        throw Exception('Апи хочет поспать');
      }
  }

  postCheckClosedAPI() {
    if (apiIsOpen && (closedForOneDayRequest && closedForThreeDayRequest)) {
        closeApi();
      }
  }
}