 import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launch/widget_screen/weather/bloc/weather_bloc.dart';
import 'package:launch/widget_screen/weather/bloc/weather_events.dart' as ev;
import 'package:launch/widget_screen/weather/bloc/weather_states.dart' as s;
import 'package:launch/widget_screen/weather/data/weather_item.dart';
import 'package:launch/widget_screen/weather/data/weather_repository.dart';
import 'package:launch/widget_screen/weather/user%20interface/city_form.dart';
import 'package:launch/widget_screen/weather/user%20interface/error_widget.dart';
import 'package:launch/widget_screen/weather/user%20interface/weather_widget_title.dart';


class WeatherWidget extends StatelessWidget {
  const WeatherWidget({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(18),
      color: Colors.blue[100],
      shape:  RoundedRectangleBorder( borderRadius: BorderRadius.circular(20)),
      child:  const WeatherBodyWidget());
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
            return MyErrorWidget(
            text: 'Ошибка сервера. \nВозможно прогноз погоды уехал в дальние страны',
            onPressed: () {
              bloc.add(ev.WeatherRequestToAPISafety());
            },);  
            }
            if (state is s.WeatherFromCityLoadingFailed) {
              return MyErrorWidget(text: 'К сожалению, по запрошенному городу нет данных\n' +
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
     for (var d in weatherForDays)  { 
      data.add(WeatherWidgetTitle(data: d));
      data.add(const SizedBox(width: 10));
    };
    return ListView(scrollDirection: Axis.horizontal,
        children: data);
    
  }

  
}





