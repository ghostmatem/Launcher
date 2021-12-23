import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class FavoriteDataProvider {
  static saveItem(String name, String packageName) async {
    SharedPreferences snapshot = await SharedPreferences.getInstance();
    snapshot.setString(name, packageName);
  }

  static Future<String?> getItem(String name) async {
    SharedPreferences snapshot = await SharedPreferences.getInstance();
    return snapshot.getString(name);
  }

  static Future<bool> deleteItem(String name) async {
    SharedPreferences snapshot = await SharedPreferences.getInstance();
    return snapshot.remove(name);
  }

  static Future<Set<String>> getAllData() async {
     SharedPreferences snapshot = await SharedPreferences.getInstance();
     var keys = snapshot.getKeys();
     return keys;
  }
}