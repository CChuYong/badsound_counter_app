import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class StateStore {
  static Future<SharedPreferences> get _instance async => sharedPreferences ??= await SharedPreferences.getInstance();
  static SharedPreferences? sharedPreferences;

  static Future<SharedPreferences> init() async {
    sharedPreferences = await _instance;
    return sharedPreferences!;
  }

  static void saveState(Type key, Map<String, dynamic> state) {
    log('saving state with ${key.toString()}');
    sharedPreferences!.setString(key.toString(), jsonEncode(state));
  }

  static Map<String, dynamic>? loadState(Type key) {
    log('loading state with ${key.toString()}');
    final data = sharedPreferences!.getString(key.toString());
    if(data == null) return null;
    return jsonDecode(data);
  }
}
