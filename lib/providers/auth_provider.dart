import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  String? _userId;
  String displayName = 'User';

  bool get isLoggedIn => _userId != null;
  String? get userId => _userId;

  bool login(String id, String password) {
    // Dummy auth: id & password tidak divalidasi ke server
    if (id.isNotEmpty && password.isNotEmpty) {
      _userId = id;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _userId = null;
    notifyListeners();
  }

  void updateProfile({String? name}) {
    if (name != null && name.isNotEmpty) {
      displayName = name;
      notifyListeners();
    }
  }
}
