import 'package:flutter/material.dart';
import 'package:launch/apps/favorite%20apps/data/favorite_repository.dart';
import '../data/app_title.dart';

// ignore: must_be_immutable
class AppListItem extends StatefulWidget {
  AppListItem({ Key? key, 
  required this.app,
  required this.needStar,
  this.externalSetState}) : super(key: key);

  final AppTitle app;
  final bool needStar;
  Function? externalSetState;
  @override
  _AppListItemState createState() => _AppListItemState();
}

class _AppListItemState extends State<AppListItem> {
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
      leading: widget.app.icon,
      trailing: IconButton(
      onPressed: () {         
        if (!widget.needStar){ 
          widget.externalSetState!(_onTapFavoriteBottom);
          }
        else {
          setState(_onTapFavoriteBottom);
      }},
      icon: widget.needStar ? _getFavoriteIcon(widget.app.isFavoriteApp) : const Icon(Icons.close_rounded)
    ),
      title: Text(widget.app.name),
      onTap: _onTapToApp,
      onLongPress: _onLongPressToApp,
    ));
  }

  void _onTapToApp() => widget.app.openApp();
  void _onLongPressToApp() => widget.app.openSettingScreen();
  

  void _onTapFavoriteBottom() {
    widget.app.isFavoriteApp
    ? FavoriteAppsRepository.deleteFromFavoriteList(widget.app)
    : FavoriteAppsRepository.addToFavoriteList(widget.app);
    widget.app.isFavoriteApp = !widget.app.isFavoriteApp;
  }
}

  Icon _getFavoriteIcon(bool isFavorite) {
    return Icon(
        isFavorite ? Icons.star_rounded : Icons.star_border_rounded,
        size: 35,
        color: Colors.blueAccent.shade700);
}