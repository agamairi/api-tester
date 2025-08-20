// lib/app_state.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  bool darkMode;
  Color themeColor;
  Map<String, String> globalVars = {};

  AppState({this.darkMode = false, this.themeColor = Colors.blue}) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    darkMode = prefs.getBool('darkMode') ?? false;
    final savedColor = prefs.getInt('themeColor');
    if (savedColor != null) themeColor = Color(savedColor);

    final varsJson = prefs.getString('globalVars');
    if (varsJson != null) {
      globalVars = Map<String, String>.from(jsonDecode(varsJson));
    }

    notifyListeners();
  }

  Future<void> toggleDarkMode(bool value) async {
    darkMode = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', darkMode);
  }

  Future<void> setThemeColor(Color color) async {
    themeColor = color;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeColor', color.value);
  }

  Future<void> addGlobalVar(String key, String value) async {
    globalVars[key] = value;
    notifyListeners();
    await _saveVars();
  }

  Future<void> removeGlobalVar(String key) async {
    globalVars.remove(key);
    notifyListeners();
    await _saveVars();
  }

  Future<void> editGlobalVar(String oldKey, String newKey, String value) async {
    globalVars.remove(oldKey);
    globalVars[newKey] = value;
    notifyListeners();
    await _saveVars();
  }

  Future<void> _saveVars() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('globalVars', jsonEncode(globalVars));
  }

  /// Expands {{variable}} inside strings
  String expandVariables(String input) {
    var result = input;
    globalVars.forEach((key, value) {
      result = result.replaceAll('{{${key}}}', value);
    });
    return result;
  }
}
