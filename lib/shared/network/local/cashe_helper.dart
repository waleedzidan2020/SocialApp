import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? Sharedpref;

  static  Init() async {
    Sharedpref = await SharedPreferences.getInstance();
  }

  static Future<bool> SaveData(
    @required String key,
    @required dynamic value,
  ) async {
    if (value is bool) return await Sharedpref!.setBool(key, value);
    if (value is String) return await Sharedpref!.setString(key, value);
    if (value is int) return await Sharedpref!.setInt(key, value);
    return await Sharedpref!.setDouble(key, value);
  }

  static Future<dynamic> GetData(@required String Key) async {
    return await Sharedpref!.get(Key);
  }

  static Future<bool> RemoveToken(@required String Key) async {
    return await Sharedpref!.remove(Key);
  }
}
