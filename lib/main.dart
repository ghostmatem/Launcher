import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launch/apps/all%20apps/bloc/app_bloc.dart';
import 'package:launch/widget_screen/weather/bloc/weather_bloc.dart';
import 'package:launch/widget_screen/weather/data/weather_repository.dart';
import 'package:launch/widget_screen/widget_screen.dart';
import 'apps/all apps/user interface/app_screen.dart';
import 'apps/favorite apps/user interface/favorite_screen.dart';

void main() { 
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<WeatherBloc>(
        create: (context) => WeatherBloc(weatherRepository),
      ),
      BlocProvider<AppBloc>
      (create: (context) => AppBloc())
    ],
    child: const AppBody()));
}

final WeatherRepository weatherRepository = WeatherRepository('e8cd0bf39a1153ba88c82c822f4466a6');


class AppBody extends StatelessWidget {
  const AppBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: PageView(children: 
        [ const WidgetScreen(), const AppScreen(), FavoriteAppsScreen()],
        )
        
    );
  }
}

