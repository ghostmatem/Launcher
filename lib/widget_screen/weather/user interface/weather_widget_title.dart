import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launch/widget_screen/weather/bloc/weather_bloc.dart';
import 'package:launch/widget_screen/weather/bloc/weather_events.dart' as ev;
import 'package:launch/widget_screen/weather/data/weather_item.dart';
import 'package:launch/widget_screen/weather/user%20interface/weather_widget_items/city_field_widget.dart';
import 'package:launch/widget_screen/weather/user%20interface/weather_widget_items/fast_weather_info_widgets.dart';
import 'package:launch/widget_screen/weather/user%20interface/weather_widget_items/weather_body_widgets.dart';

class WeatherWidgetTitle extends StatelessWidget {
  const WeatherWidgetTitle
({ Key? key, required this.data }) : super(key: key);

final WeatherItem data;
final double standartFontSize = 19;
final double standartWidth = 100;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      child: Column(
        children: [
          data.isMain ?
          Stack(
            alignment: Alignment.center,
            children: [
              CityField(sity: data.city),
              Row(
                children: [
                  const SizedBox(width: 35),
                  TextButton(onPressed: (){
                    context.read<WeatherBloc>().add(ev.WeatherChoiseCity());
                  }, 
                  child: const SizedBox(height: 40, width: 200,)
                  ),
                  const SizedBox(width: 30),
                  IconButton(icon: const Icon(Icons.refresh_outlined, size: 30),
                  onPressed: (){
                    context.read<WeatherBloc>().add(ev.WeatherTryRequest());
                  })
                ],
              ),               
            ],
          )
          : CityField(sity: data.city) ,
          Row(
            children: [  
              const SizedBox(width: 16),
                MainTemperatureInfo(data: data),
              const SizedBox(width: 6),
                 IconWidget(iconCode: data.iconCode),      
            ],
          ),
          FastInfoBar(data: data, standartWidth: standartWidth, standartFontSize: standartFontSize)
        ],
      ),
    );
  }
}
