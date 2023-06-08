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

  static void saveState(dynamic key, Map<String, dynamic> state) {
    log('saving state with ${key.runtimeType.toString()}');
    sharedPreferences!.setString(key.runtimeType.toString(), jsonEncode(state));
  }

  static Map<String, dynamic>? loadState(dynamic key) {
    log('loading state with ${key.runtimeType.toString()}');
    final data = sharedPreferences!.getString(key.runtimeType.toString());
    if(data == null) return null;
    return jsonDecode(data);
  }
}
