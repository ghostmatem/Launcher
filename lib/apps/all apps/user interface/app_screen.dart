import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:launch/apps/all%20apps/search/search_delegate.dart';
import 'package:launch/apps/favorite%20apps/data/favorite_d_provider.dart';
import 'package:launch/apps/favorite%20apps/data/favorite_repository.dart';
import 'package:launch/apps/favorite%20apps/user%20interface/favorite_screen.dart';
import '../data/app_repository.dart';
import 'app_item_list.dart';


class AppScreen extends StatelessWidget {
  const AppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Scaffold( 
      appBar: AppBar(centerTitle: true, 
      backgroundColor: 
      Colors.blue[300],
      title: const MyTextForAppBar('Приложения'),
      actions: [
        Container(
          child: IconButton(icon: Icon(Icons.manage_search_sharp, size: 40, 
              color: Colors.grey[850] ),
              onPressed: () => showSearch(context: context, delegate: MySearchDelegate())),
              padding: const EdgeInsets.fromLTRB(0,0,20,20),
        )
      ],),
      body: const AppWidget());
}


class AppWidget extends StatefulWidget {
const AppWidget({Key? key}) : super(key: key);

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
      if (AppsRepository.apps.isEmpty) {
      _whenOpenAppUpdate();    
    }
    super.initState();
  }

  void _whenOpenAppUpdate() {
    AppsRepository.getInstalledApps().then((data) {
      AppsRepository.updateData(data);
      FavoriteDataProvider.getAllData().then((names) {
        FavoriteAppsRepository.updateFavoriteList(names);
        setState(() {});
      });
    });   
  }

  @override
  Widget build(BuildContext context) {
    if (AppsRepository.apps.isNotEmpty) {
      return ListView.builder(
          itemCount: AppsRepository.apps.length,
          itemBuilder: (context, index) {
            return AppListItem(app: AppsRepository.apps[index], needStar: true);
          });
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

}
