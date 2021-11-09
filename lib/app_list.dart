import 'package:flutter/material.dart';
import 'detail_screen.dart';

class AppList extends StatelessWidget {
  const AppList({
    Key? key,
    required this.appTitle,
  }) : super(key: key);

  final String appTitle;
  @override
  Widget build(BuildContext context) =>
       Card(
        child: ListTile(
            leading: Image.network(
              'https://thumbs.dreamstime.com/b/значок-приложения-музыки-с-предпосылкой-градиента-изумляя-для-148637581.jpg',
              height: 45,
              width: 45,
            ),
            title: Container(child: Text(appTitle), padding: const EdgeInsets.all(5.0),),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AppDetail(appTitle: appTitle))
                )));
  
}
