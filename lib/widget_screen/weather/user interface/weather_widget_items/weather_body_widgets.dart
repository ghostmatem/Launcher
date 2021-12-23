import 'package:flutter/material.dart';
import 'package:launch/widget_screen/weather/data/weather_item.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({
    Key? key,
    required this.iconCode,
  }) : super(key: key);

  final String? iconCode;

  @override
  Widget build(BuildContext context) {
    final image = Image.network("http://openweathermap.org/img/wn/$iconCode@4x.png", scale: 0.2,
         filterQuality: FilterQuality.medium,
         width: 200,
         height: 200);

    return Container(
      // color: Colors.green[200],
      margin: const EdgeInsets.fromLTRB(0, 8, 0, 16),
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                height: 110,
                width: 110,
                child:  image                         
                );
  }
}

class MainTemperatureInfo extends StatelessWidget {
  const MainTemperatureInfo({
    Key? key,
    required this.data,
  }) : super(key: key);

  final WeatherItem data;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.green[200],
    margin: const EdgeInsets.fromLTRB(0, 0, 2, 0),
    padding: data.decription.length > 17  
    ? const EdgeInsets.fromLTRB(0, 2, 0, 6)
    : const EdgeInsets.fromLTRB(0, 4, 0, 16),
    height: 110,
    width: 200,
    alignment: Alignment.center,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('${data.temperature}°C',
        style: const TextStyle(fontSize: 55, 
        fontWeight: FontWeight.w300,
        fontStyle: FontStyle.italic),),
        Flexible(
          child: Container(
            // color: Colors.green[400],
            alignment: data.decription.length > 20 ? Alignment.center : Alignment.topCenter,
            child: Text(data.decription, style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic),
               textAlign: TextAlign.center),
          ),
        ),
      ],
    ),
              );
  }
}