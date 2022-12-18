import 'package:shared_preferences/shared_preferences.dart';

const String userObjectKey = 'user_object';
const String locationServiceScanIntervalKey = 'location_service_scan_interval';
const String userTerritoryKey = 'user_territory_key';
const String LANGUAGE_CODE = 'language_code';
const String PRODUCTS_VIEW_TYPE_SELECTION = 'isGrid'; // Grid or List
const String FIREBASE_MESSAGING_TOKEN = 'firebase_messaging_token';

class SharedPrefs {
  SharedPreferences? _sharedPrefs;

  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  // Logged in User
  String get user => _sharedPrefs!.getString(userObjectKey) ?? '';

  set user(String value) {
    _sharedPrefs!.setString(userObjectKey, value);
  }

  // Location service scan interval
  int get locationServiceScanInterval =>
      _sharedPrefs!.getInt(locationServiceScanIntervalKey) ?? 60;

  set locationServiceScanInterval(int value) {
    _sharedPrefs!.setInt(locationServiceScanIntervalKey, value);
  }

  // User Territory UUID
  String get userTerritory => _sharedPrefs!.getString(userTerritoryKey) ?? '';

  set userTerritory(String value) {
    _sharedPrefs!.setString(userTerritoryKey, value);
  }

  Future resetUser() async {
    await _sharedPrefs!.remove(userObjectKey);
  }

  // transaction sharedprefs

  void reload() => _sharedPrefs!.reload();

  String get languageCode => _sharedPrefs!.getString(LANGUAGE_CODE) ?? "en";

  set languageCode(String value) {
    _sharedPrefs!.setString(LANGUAGE_CODE, value);
  }

  bool get isGrid => _sharedPrefs!.getBool(PRODUCTS_VIEW_TYPE_SELECTION) ?? true;

  set isGrid(bool value) {
    _sharedPrefs!.setBool(PRODUCTS_VIEW_TYPE_SELECTION, value);
  }


  String? get firebaseMessagingToken => _sharedPrefs!.getString(FIREBASE_MESSAGING_TOKEN);

  set firebaseMessagingToken(String? value) {
    _sharedPrefs!.setString(FIREBASE_MESSAGING_TOKEN, value!);
  }



  void reset() {
    _sharedPrefs!.getKeys();
    for (String key in _sharedPrefs!.getKeys()) {
      if (key != LANGUAGE_CODE) {
        _sharedPrefs!.remove(key);
      }
    }
  }
}

