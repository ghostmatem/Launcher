import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launch/widget_screen/weather/bloc/weather_states.dart' as s;
import 'package:launch/widget_screen/weather/data/weather_repository.dart';
import 'weather_events.dart' as ev;


class WeatherBloc extends Bloc<ev.WeatherEvent, s.WeatherState> {
  final WeatherRepository repository;
  

  WeatherBloc(this.repository) : super(s.WeatherWidgetNeedData()) {
    print('bloc - стань похожим на мох');
    // repository.openApi();

    on<ev.WeatherTryRequest>((event, emit) async {
      try {
        await repository.tryInitCity();
        if (repository.WeatherExist && repository.apiClosed) {
            emit(s.WeatherLoadingSuccess(repository.Weathers, false));
            return;
        } else {
          add(ev.WeatherRequestToAPISafety());
        }      
      } catch(_) {
        add(ev.WeatherChoiseCity());
      }       
    });

    on<ev.WeatherRequestToAPISafety>((event, emit) async {
      try{
        await _requestToApi(emit, repository.City);
        } catch (_) {
          add(ev.WeatherRequestedMemory());
        }
      });

    on<ev.WeatherChoiseCity>((event, emit) async {
        emit(s.WeatherChoisingCity());
    });

    on<ev.WeatherPushedNewCity>((event, emit) async {    
        try {
          String value = event.city;
          await repository.openApi();
          await _requestToApi(emit, value);
          repository.City = event.city;
        } catch (_) {
          emit(s.WeatherFromCityLoadingFailed());
        }
    });

    on<ev.WeatherRequestedMemory>((event, emit) async {
      try {
        await _requestToMemory(emit);
        } catch (_) {
          emit(s.WeatherLoadingFailed());               
        }
    });
  }

  Future<void> _requestToMemory(Emitter<s.WeatherState> emit) async {
    emit(s.WeatherDataIsLoaded());
    var weatherList = await repository.getWeatherFromMemory();
    emit(s.WeatherLoadingSuccess(weatherList, true));
  }

  Future<void> _requestToApi(Emitter<s.WeatherState> emit, String city) async {
    emit(s.WeatherDataIsLoaded());
    await repository.tryInitTimeLastRequest();  
    var weatherList = await repository.getWeatherFromAPI(city);
    emit(s.WeatherLoadingSuccess(weatherList, true));
  }
}