import 'package:flutter/material.dart';
import 'package:launch/widget_screen/weather/data/weather_item.dart';

class FastInfoBar extends StatelessWidget {
  const FastInfoBar({
    Key? key,
    required this.data,
    required this.standartWidth,
    required this.standartFontSize,
  }) : super(key: key);

  final WeatherItem data;
  final double standartWidth;
  final double standartFontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 330,
      child: Row(
        children: [     
          FastWeatherInfo(
            icon: data.isMain 
            ? const Icon(Icons.people_outline_outlined, size: 25) 
            : const Icon(Icons.arrow_circle_down_sharp, size: 27), 
            info: data.isMain 
            ? '${data.feelTemp}°C'
            : '${data.minTemp}°C',
            width: standartWidth,
            fontSize: standartFontSize),  
          FastWeatherInfo(
            icon: data.isMain 
            ? const Icon(Icons.water_damage_rounded, size: 27)
            : const Icon(Icons.arrow_circle_up_sharp, size: 27), 
            info: data.isMain 
            ? '${data.humidity}%'
            : '${data.maxTemp}°C',
            width: standartWidth,
            fontSize: standartFontSize),  
          FastWeatherInfo(
            icon: const Icon(Icons.air_sharp, size: 27), 
            info: '${data.wideSpeed} m/s',
            width: standartWidth,
            fontSize: standartFontSize),    
        ],
      ),
    );
  }
}

class FastWeatherInfo extends StatelessWidget {
  const FastWeatherInfo({
    Key? key, required this.icon, required this.info, this.height = 40, 
    this.width = 80, this.color, this.fontSize = 17.5,
  }) : super(key: key);

  final Icon icon;
  final String info;
  final double? height;
  final double? width;
  final Color? color;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    var widthInfo = width! * 0.6;
    return Card(
      color: color ?? Colors.blue[200],
      child: Container(
        width: width,
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              transformAlignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(right: 1, left: 1),
              child: icon),
            Container(
              width: widthInfo,
              alignment: Alignment.center,
              child: Text(info, 
              style: const TextStyle(fontSize: 16.5, fontWeight: FontWeight.w600)),
            )
          ],
        ),
      ),
    );
  }
}