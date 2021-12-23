import 'package:flutter/material.dart';
import 'package:launch/widget_screen/calculator_widget.dart';
import 'package:launch/widget_screen/clock_widget.dart';
import 'package:launch/widget_screen/weather/data/weather_repository.dart';
import 'package:launch/widget_screen/weather/user%20interface/weather_wigdet.dart';

class WidgetScreen extends StatelessWidget {
const WidgetScreen
({ Key? key, required this.repository}) : super(key: key);

  final WeatherRepository repository;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const SizedBox(height: 80),
          const MyClock(),        
          WeatherWidget(repository: repository),        
          const CalculatorWidget()]));                             
      }
             
}
