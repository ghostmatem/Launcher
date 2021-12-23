 import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launch/widget_screen/weather/bloc/weather_bloc.dart';
import 'package:launch/widget_screen/weather/bloc/weather_events.dart' as ev;
import 'package:launch/widget_screen/weather/bloc/weather_states.dart' as s;
import 'package:launch/widget_screen/weather/data/weather_repository.dart';
import 'package:launch/widget_screen/weather/user%20interface/city_form.dart';
import 'package:launch/widget_screen/weather/user%20interface/weather_widget_title.dart';


class WeatherWidget extends StatelessWidget {
  const WeatherWidget({
    Key? key,
    required this.repository,
  }) : super(key: key);

  final WeatherRepository repository;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(18),
      color: Colors.blue[100],
      shape:  RoundedRectangleBorder( borderRadius: BorderRadius.circular(20)),
      child:  BlocProvider<WeatherBloc>(
        create: (context) => WeatherBloc(repository),
        child: const WeatherBodyWidget()));
  }
}


 class WeatherBodyWidget extends StatelessWidget {
  const WeatherBodyWidget({
    Key? key}) : super(key: key); 


  @override
  Widget build(BuildContext context) {
    var bloc = context.watch<WeatherBloc>();
    return Container(
      margin: const EdgeInsets.only(left: 10),
      width: 400,
      height: 250,
        child: BlocBuilder<WeatherBloc, s.WeatherState>(
           builder: (context, state) {
            if (state is s.WeatherWidgetNeedData) {
               bloc.add(ev.WeatherTryRequest());
            }
            if (state is s.WeatherLoadingSuccess) {  
              return _buildWidget(state);                                   
            }
            if (state is s.WeatherDataIsLoaded) {
             return Container(
               alignment: Alignment.center,
               child: const CircularProgressIndicator());           
            }
            if(state is s.WeatherLoadingFailed) {
              bloc.add(ev.WeatherStartTimerToRequest());
            } 
            if (state is s.WeatherChoisingCity) {
              return CityForm();
            }
                  
            if (state is s.WeatherLoadingFailed) {
            Timer(const Duration(minutes: 2), (){
                if (state is s.WeatherLoadingFailed) {
                  bloc.add(ev.WeatherRequestToAPISafety());
                }
            }); 
            return ErrorWidget(
            text: 'Ошибка сервера. \nВозможно прогноз погоды уехал в дальние страны',
            onPressed: () {
              bloc.add(ev.WeatherRequestToAPISafety());
            },);  
            }
            if (state is s.WeatherFromCityLoadingFailed) {
              return ErrorWidget(text: 'К сожалению, по запрошенному городу нет данных\n' +
              'Попробуйте снова', onPressed: (){
                bloc.add(ev.WeatherChoiseCity());
              });
            }           
            return Container(alignment: Alignment.center, child: const CircularProgressIndicator());           
            }
         ),
       );
  }

  ListView _buildWidget(s.WeatherLoadingSuccess state) {
    var weatherForDays = state.data;
    List<Widget> data = [];
    weatherForDays.forEach((element) {
      data.add(WeatherWidgetTitle(data: element));
      data.add(const SizedBox(width: 10));
    });       
    return ListView(scrollDirection: Axis.horizontal,
        children: data);
    
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    Key? key,
    required this.text, required this.onPressed,
  }) : super(key: key);

  final Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
       alignment: Alignment.center,
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
            Text(text,
            textAlign: TextAlign.center, 
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
            IconButton(icon: const Icon(Icons.replay_outlined, 
            size: 50, color: Color.fromRGBO(48, 48, 48, 1)),
            onPressed: onPressed),
         ],
       ));
  }
}


