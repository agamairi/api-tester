import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  MaterialColor _seedColor = Colors.blue;

  ThemeProvider() {
    _loadPreferences();
  }

  ThemeMode get themeMode => _themeMode;
  MaterialColor get seedColor => _seedColor;

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _savePreferences();
    notifyListeners();
  }

  void setSeedColor(MaterialColor color) {
    _seedColor = color;
    _savePreferences();
    notifyListeners();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString('themeMode') ?? 'system';
    final colorIndex = prefs.getInt('seedColor') ?? Colors.blue.value;

    _themeMode = themeString == 'dark'
        ? ThemeMode.dark
        : themeString == 'light'
        ? ThemeMode.light
        : ThemeMode.system;

    _seedColor = Colors.primaries.firstWhere(
      (c) => c.value == colorIndex,
      orElse: () => Colors.blue,
    );

    notifyListeners();
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'themeMode',
      _themeMode == ThemeMode.dark
          ? 'dark'
          : _themeMode == ThemeMode.light
          ? 'light'
          : 'system',
    );
    await prefs.setInt('seedColor', _seedColor.value);
  }
}
