import 'package:se7ety/core/enum/user_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocalStorage {
  static const String token = "token";
  static const String isOnboardingShown = "isOnboardingShown";
  static const String userToken = "userToken";
  static const String isLoggedIn = "isLoggedIn";
  static const String userTypeKey = "userType";

  static late SharedPreferences _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static cacheData({required String key, required dynamic value}) async {
    if (value is String) {
      await _sharedPreferences.setString(key, value);
    } else if (value is int) {
      await _sharedPreferences.setInt(key, value);
    } else if (value is bool) {
      await _sharedPreferences.setBool(key, value);
    } else if (value is double) {
      await _sharedPreferences.setDouble(key, value);
    } else {
      await _sharedPreferences.setStringList(key, value);
    }
  }

  static dynamic getData({required String key}) {
    return _sharedPreferences.get(key);
  }

  static Future<void> setUserType(UserType userType) async {
    await cacheData(key: userTypeKey, value: userType.name);
  }

  static UserType? getUserType() {
    String? userTypeString = getData(key: userTypeKey) as String?;

    // If the value is not null, try to convert it to UserType
    if (userTypeString != null) {
      return UserType.values.firstWhere(
        (type) => type.name == userTypeString,
        orElse: () => UserType.patient, // Default to "patient" if parsing fails
      );
    }

    // If no value is found, return null
    return null;
  }
}
