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

  static Future<List<AppInfo>> getInstalledApps() async{
    List<AppInfo> apps = await InstalledApps.getInstalledApps(true, true, "");
    return apps;
  }

  static void updateData(List<AppInfo> data) {
    apps = getAppTitleList(data);
    getNameWidgetMap(apps).then((value) {
      mapWidget = value;
    });
  }

  static Future<Map<String, AppListItem>> getNameWidgetMap(List<AppTitle> data) async {
    Map<String, AppListItem> result = {};
      for (var app in data) {
      var key = app.name.toLowerCase();
      keys.add(key);
      result[key] = AppListItem(app: app, needStar: true);
    }
    return result;
  }

  static List<AppTitle> getAppTitleList(List<AppInfo> appsInfo) {
    List<AppTitle> result  = [];
    for (var appInfo in appsInfo) {
        result.add(AppTitle(
          appInfo.name!, appInfo.packageName, Image.memory(appInfo.icon!, width: 35), false));
    }
    return result;
  }

  static openApp(String packageName) => InstalledApps.startApp(packageName);
  static openSettingScreen(String packageName) => InstalledApps.openSettings(packageName);
}