import 'package:flutter/material.dart';
import 'package:launch/apps/all%20apps/user%20interface/app_item_list.dart';
import 'dart:async';
import 'app_title.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:installed_apps/app_info.dart';


class AppsRepository {
  static List<AppTitle> apps  = [];
  static List<String> keys = [];
  static Map<String, AppListItem> mapWidget = {};

  static Future<List<AppTitle>> getInstalledApps() async{
    
    if (apps.isEmpty) {
      List<AppInfo> gettedApps = await InstalledApps.getInstalledApps(true, true, "");
      var stream = await getAppTitleList(gettedApps).toList();

      for (var app in stream) {
        apps.add(app);
        var key = app.name.toLowerCase();
        keys.add(key);
        mapWidget[key] = AppListItem(app: app, needStar: true);
      }  
    }  
    return apps;  
  }

  static Stream<AppTitle> getAppTitleList(List<AppInfo> appsInfo) async* {
    for (var appInfo in appsInfo) {
        var result  = AppTitle(
          appInfo.name!, appInfo.packageName, Image.memory(appInfo.icon!, width: 35), false);
        yield result;
    }
  }

  static openApp(String packageName) => InstalledApps.startApp(packageName);
  static openSettingScreen(String packageName) => InstalledApps.openSettings(packageName);
}