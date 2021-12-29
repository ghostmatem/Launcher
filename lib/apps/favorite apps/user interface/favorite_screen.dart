import 'package:flutter/material.dart';
import 'package:launch/apps/all%20apps/data/app_title.dart';
import 'package:launch/apps/all%20apps/user%20interface/app_item_list.dart';
import 'package:launch/apps/favorite%20apps/data/favorite_repository.dart';




class FavoriteAppsScreen extends StatefulWidget {
  FavoriteAppsScreen({Key? key}) : super(key: key);
  bool orderByABC = false;
  List<AppTitle> favoriteApps = [];
  @override
  _FavoriteAppsScreenState createState() => _FavoriteAppsScreenState();
}

class _FavoriteAppsScreenState extends State<FavoriteAppsScreen> {
  

  @override
  void initState() {
    if (widget.favoriteApps.isEmpty) {
      _updateFavoriteApps();  
    }    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue[300],
          title: const MyTextForAppBar('Neo\'s'),
        ),
        body: widget.favoriteApps.isNotEmpty
            ? _getFavoriteAppsListView()
            : _getEmptyMassage(),
        floatingActionButton: Container(
          child: getFloatingActionBottom(),
              padding: const EdgeInsets.all(20.0),
        ));
  }

  IconButton getFloatingActionBottom() {
    return IconButton(           
            icon: Icon(
              widget.orderByABC ? Icons.sort : Icons.source_outlined, 
              color: Colors.blue.shade600,
              size: 40),
            onPressed: () {
              setState(() {
                widget.orderByABC = !widget.orderByABC;
                _updateFavoriteApps();
              });
            });
  }

  Center _getEmptyMassage() {
    return Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: const Text(
                "Ну ты это, заходи если что :3",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
            ),
              ));
  }

  _updateFavoriteApps() {
    widget.favoriteApps = widget.orderByABC
        ? FavoriteAppsRepository.getOrderFavoriteList()
        : FavoriteAppsRepository.getFavoriteList();
  }

  ListView _getFavoriteAppsListView() {
    return ListView.builder(
      itemCount: widget.favoriteApps.length,
      itemBuilder: (context, index) {
        return AppListItem(
            app: widget.favoriteApps[index],
            needStar: false,
            externalSetState: setState);
      });
    }
    
}

class MyTextForAppBar extends StatelessWidget {
  const MyTextForAppBar( this.text, {
    Key? key,
  }) : super(key: key);
  
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontFamily: 'Roboto', 
    fontSize: 35, fontWeight: FontWeight.w300, color: Colors.grey[850]));
  }
}

