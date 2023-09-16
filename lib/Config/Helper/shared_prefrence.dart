import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreference{
  static SharedPreferences? _preferences;
  static const  _keyUserName='username';

  static Future init() async=>
      _preferences=await SharedPreferences.getInstance();

  static Future setUserName(String username) async =>
      await _preferences?. setString(_keyUserName, username);
  static String? getUserName()=>_preferences?.getString(_keyUserName);  //this is simple methode


  static Future setString(String key,String value) async=>
      await _preferences?.setString(key, value);
  static String? getString(key)=>_preferences?.getString(key);     //this is methode on wich single methode need to call only for every data

  static Future setBool(String key,bool value) async=>
      await _preferences?.setBool(key, value);
  static bool? getBool(key)=>_preferences?.getBool(key);

  static Future setInt(String key,int value) async=>
      await _preferences?.setInt(key, value);
  static int? getInt(key)=>_preferences?.getInt(key);



}

