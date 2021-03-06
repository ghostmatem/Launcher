import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launch/widget_screen/weather/bloc/weather_bloc.dart';
import 'package:launch/widget_screen/weather/bloc/weather_events.dart' as ev;
import 'package:launch/widget_screen/weather/bloc/weather_states.dart' as s;
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

late ListView listView;

 class WeatherBodyWidget extends StatelessWidget {
 const WeatherBodyWidget({
    Key? key}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      width: 400,
      height: 250,
        child: BlocBuilder<WeatherBloc, s.WeatherState>(           
           builder: (context, state) {
            if (state is s.WeatherWidgetNeedData) {
               context.read<WeatherBloc>().add(ev.WeatherTryRequest());
            }
            else if (state is s.WeatherLoadingSuccess) {  
              
                return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.data.length,
                itemBuilder: (context, i) {
                  return WeatherWidgetMainTitle(data: state.data[i]);
                                    });  
                                               
              }
            else if (state is s.WeatherDataIsLoaded) {
             return Container(
               alignment: Alignment.center,
               child: const CircularProgressIndicator());           
            }
            else if (state is s.WeatherChoisingCity) {
              return CityForm();
            }                  
            else if (state is s.WeatherLoadingFailed) {             
            return MyErrorWidget(
            text: '???????????? ??????????????. \n???????????????? ?????????????? ???????????? ?????????? ?? ?????????????? ????????????',
            onPressed: () {
              context.read<WeatherBloc>().add(ev.WeatherRequestToAPISafety());
            },);  
            }
            else if (state is s.WeatherFromCityLoadingFailed) {
              return MyErrorWidget(text: '?? ??????????????????, ???? ???????????????????????? ???????????? ?????? ????????????\n' +
              '???????????????????? ??????????', onPressed: (){
                context.read<WeatherBloc>().add(ev.WeatherChoiseCity());
              });
            }            
               return Container(
               alignment: Alignment.center,
               child: const CircularProgressIndicator());                                                    
           }),
       );
  }
}




// else if (state is s.WeatherLoadingSuccess) {  
//               if (state.isUpdate) {
//                 listView = ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: state.data.length,
//                 itemBuilder: (context, i) {
//                   return WeatherWidgetMainTitle(data: state.data[i]);
//                                     });  
//               }
//                   return listView;                                   
//               }
