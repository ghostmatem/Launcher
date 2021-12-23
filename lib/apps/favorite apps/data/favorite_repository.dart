import 'package:flutter/material.dart';
import 'package:launch/apps/all%20apps/data/app_repository.dart';
import 'package:launch/apps/all%20apps/data/app_title.dart';
import 'favorite_d_provider.dart';


class FavoriteAppsRepository {
  static List<AppTitle> favoriteApps = [];
  static List<AppTitle> favoriteAppsOrder = [];
 
  static void updateFavoriteList(Set<String> favoriteNames) {  
    if (favoriteNames.isNotEmpty) {
      for (var name in favoriteNames) {
        if (name[0] == '_') continue;
        for (var app in AppsRepository.apps) {
          if (app.name == name) {
            app.isFavoriteApp = true;
            favoriteApps.add(app);
            favoriteAppsOrder.add(app);
            break;
          }
        }
      }
    favoriteAppsOrder.sort();
    }
  }

  static void addToFavoriteList(AppTitle app) {
    if (!isContains(app.name)) {
      favoriteApps.add(app);
      favoriteAppsOrder.add(app);   
      FavoriteDataProvider.saveItem(app.name, app.packageName!);
      favoriteAppsOrder.sort();
    }
  }

  static bool isContains(String appName) {
    for (var item in favoriteAppsOrder) {
      if (item.name == appName) {
        return true;
      }
    }
    return false;
  }

  static void deleteFromFavoriteList(AppTitle app) {
    favoriteAppsOrder.remove(app);
    favoriteApps.remove(app);
    FavoriteDataProvider.deleteItem(app.name);
  }

  static List<AppTitle> getFavoriteList() => favoriteApps;

  static List<AppTitle> getOrderFavoriteList() => favoriteAppsOrder;
}