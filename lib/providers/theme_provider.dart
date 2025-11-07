import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode mode = ThemeMode.system; // default adaptive: ikut system

  void toggle(bool isDark) {
    mode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void useSystem() {
    mode = ThemeMode.system;
    notifyListeners();
  }
}
