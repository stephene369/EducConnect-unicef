import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  final SharedPreferences prefs;
  bool _isDarkMode = false;
  String _language = 'fr';
  String _userName = 'Aminata';

  AppProvider(this.prefs) {
    _loadPreferences();
  }

  bool get isDarkMode => _isDarkMode;
  String get language => _language;
  String get userName => _userName;

  void _loadPreferences() {
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _language = prefs.getString('language') ?? 'fr';
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  void setLanguage(String lang) {
    _language = lang;
    prefs.setString('language', lang);
    notifyListeners();
  }
}