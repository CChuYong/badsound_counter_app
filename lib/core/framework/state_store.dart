import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class StateStore {
  static Future<SharedPreferences> get _instance async =>
      sharedPreferences ??= await SharedPreferences.getInstance();
  static SharedPreferences? sharedPreferences;

  static Future<SharedPreferences> init() async {
    sharedPreferences = await _instance;
    print("INITIALIZE SHAREDPREF");
    sharedPreferences!.getKeys().forEach((element) {
      print(element);
    });
    return sharedPreferences!;
  }

  static void saveState(Type key, Map<String, dynamic> state) async {
    try{
      print('saving state with ${key.toString()} as ${jsonEncode(state)}');
      await sharedPreferences!.setString(key.toString(), jsonEncode(state));
    }catch(e){
      print(e);
    }
  }

  static Map<String, dynamic>? loadState(Type key) {
    print('loading state with ${key.toString()}');
    final data = sharedPreferences!.getString(key.toString());
    if (data == null) return null;
    return jsonDecode(data);
  }

  static void clearState(Type key) {
    sharedPreferences!.remove(key.toString());
  }

  static void clear() {
    sharedPreferences!.clear();
  }
}
