import 'package:shared_preferences/shared_preferences.dart';

class HiCache {
  SharedPreferences? prefs;

  HiCache._() {
    init();
  }

  static HiCache? _instance;

  HiCache._pre(this.prefs);

  ///与初始化，防止在使用get时，prefs还没初始化完成
  static Future<HiCache> preInit() async {
    if (_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = HiCache._pre(prefs);
    }
    return _instance!;
  }

  static HiCache getInstance() {
    return _instance ??= HiCache._();
  }

  void init() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  setBool(String key, bool value) {
    prefs?.setBool(key, value);
  }

  setInt(String key, int value) {
    prefs?.setInt(key, value);
  }

  setDouble(String key, double value) {
    prefs?.setDouble(key, value);
  }

  setString(String key, String value) {
    prefs?.setString(key, value);
  }

  setStringList(String key, List<String> value) {
    prefs?.setStringList(key, value);
  }

  Object? get(String key) {
    return prefs?.get(key);
  }
}
