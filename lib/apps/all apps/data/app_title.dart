import 'package:flutter/material.dart';
import 'package:installed_apps/installed_apps.dart';



class AppTitle extends Comparable{
  AppTitle(this.name, this.packageName, this.icon, this.isFavoriteApp);

  final String name;
  final String? packageName;
  final Image icon;
  bool isFavoriteApp;

  openApp() => InstalledApps.startApp(packageName!);
  openSettingScreen() => InstalledApps.openSettings(packageName!);

  @override
  int compareTo(other) => name.compareTo(other.name);
}