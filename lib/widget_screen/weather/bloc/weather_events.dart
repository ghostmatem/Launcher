import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class WeatherTryRequest extends WeatherEvent { }
class WeatherRequestToAPISafety extends WeatherEvent{ }
class WeatherRequestedMemory extends WeatherEvent { }
class WeatherStartTimerToRequest extends WeatherEvent { }
class WeatherResetRequestCounter extends WeatherEvent { }
class WeatherChoiseCity extends WeatherEvent { }
class WeatherPushedNewCity extends WeatherEvent { 
  final String city;
  const WeatherPushedNewCity(this.city);
  @override
  List<Object?> get props => [city];
 }
