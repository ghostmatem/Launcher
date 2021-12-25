import 'package:equatable/equatable.dart';
import 'package:launch/widget_screen/weather/data/weather_item.dart';


abstract class WeatherState extends Equatable {
  const WeatherState();

   @override
  List<Object> get props => [];
}

class WeatherWidgetNeedData extends WeatherState { }
class WeatherDataIsLoaded extends WeatherState { }
class WeatherLoadingFailed extends WeatherState { }
class WeatherChoisingCity extends WeatherState { }
class WeatherFromCityLoadingFailed extends WeatherState { }
class WeatherLoadingSuccess extends WeatherState { 
  const WeatherLoadingSuccess(this.data, this.isUpdate);

  final List<WeatherItem> data;
  final bool isUpdate;

  @override
  List<Object> get props => [data, isUpdate];
}
  

