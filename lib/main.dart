import 'package:flutter/material.dart';
import 'package:launch/widget_screen/weather/bloc/weather_bloc.dart';
import 'package:launch/widget_screen/weather/data/weather_repository.dart';
import 'package:launch/widget_screen/widget_screen.dart';
import 'apps/all apps/user interface/app_screen.dart';
import 'apps/favorite apps/user interface/favorite_screen.dart';

void main() { 
  runApp(const AppBody());
}

final WeatherRepository weatherRepository = WeatherRepository('e8cd0bf39a1153ba88c82c822f4466a6');


class AppBody extends StatelessWidget {
  const AppBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: PageView(children: 
        [ WidgetScreen(repository: weatherRepository), const AppScreen(), FavoriteAppsScreen()],
        )
        
    );
  }
}

// Вряд ли виджет будет адаптироваться под экран, 
// так что можно юзать хотя бы то, что по посл ссылке открыто
// Все ещё не работает на релизе)))
// Сделать если данные в репозитории есть и апи закрыто, стадия не обновляется на загруженную, ввести стадию
// Данные уже имеются

// Вместо скафолда сунуть часы в фэворит
// Сделать управление более человеческим

// Добавить строку поиска приложений
// Привести все к одному дизайну

