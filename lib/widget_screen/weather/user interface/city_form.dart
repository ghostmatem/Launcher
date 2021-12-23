import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launch/widget_screen/weather/bloc/weather_bloc.dart';
import 'package:launch/widget_screen/weather/bloc/weather_events.dart' as ev;
import 'package:provider/src/provider.dart';

class CityForm extends StatelessWidget {
  CityForm({
    Key? key,
  }) : super(key: key);

  final TextEditingController controllerCityInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<WeatherBloc>(context, listen: true);
    return Container(
      width: 180,
      height: 200,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [          
            Container(
              height: 70,
              padding: const EdgeInsets.only(bottom: 15),
              alignment: Alignment.topLeft,
              child:  !bloc.repository.CityUndefined
              ? IconButton(onPressed: () {
                bloc.add(ev.WeatherRequestedMemory());
                }, 
                icon: const Icon(Icons.keyboard_backspace_rounded, size: 50, 
                  color: Color.fromRGBO(48, 48, 48, 1)))
              : const SizedBox()),
                  
            TextField(
            controller: controllerCityInput,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              icon: Icon(Icons.location_on_rounded, size: 50),
              hintText: 'Введите свой город',
              hintStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w300, fontStyle: FontStyle.italic),
              border: InputBorder.none),
              style: const TextStyle(fontSize: 35, fontWeight: FontWeight.w300),
              ),                           
              Container(
                height: 70,
                padding: const EdgeInsets.fromLTRB(0, 0, 19, 0),
                alignment: Alignment.bottomRight,
                child: IconButton(onPressed: (){
                  var value = controllerCityInput.text;
                  bloc.add(ev.WeatherPushedNewCity(value));
                }, icon: const Icon(Icons.done_rounded, size: 50, 
                    color: Color.fromRGBO(48, 48, 48, 1))),
              )
        ],
      ),
    );
  }
}