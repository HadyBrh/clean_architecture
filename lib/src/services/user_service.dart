import 'dart:convert';


import '../features/user/data/model/user.dart';
import '../utils/locator/locator.dart';
import 'shared_preferences_service.dart';

class UserService {
  User? user;

  /// Get user from shared preferences if exist
  void initialise() {
    if (locator<SharedPrefs>().user.isEmpty) return;

    var loggedInUser = jsonDecode(locator<SharedPrefs>().user);

    /// set user instance
    user = User.fromJson(loggedInUser);
  }

  /// Save user in shared preferences
  void saveUser({required User user}) async {
    /// set user instance
    this.user = user;
    locator<SharedPrefs>().user = jsonEncode(user);
  }

  /// Checks if user is authenticated
  /// @parameters: -
  /// return bool
  bool isAuthenticated() {
    return user != null;
  }

  Future logout() async {
    user = null;
    await locator<SharedPrefs>().resetUser();
  }

}
