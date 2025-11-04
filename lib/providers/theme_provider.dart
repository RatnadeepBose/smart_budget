import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class ThemeProvider with ChangeNotifier {
  late Box _settingsBox;
  bool _isInitialized = false;

  ThemeProvider() {
    _init();
  }

  Future<void> _init() async {
    _settingsBox = Hive.box('settings');
    _isInitialized = true;
    notifyListeners();
  }

  bool get isDarkMode {
    if (!_isInitialized) return false;
    return _settingsBox.get('isDarkMode', defaultValue: false);
  }

  Future<void> setDarkMode(bool value) async {
    await _settingsBox.put('isDarkMode', value);
    notifyListeners();
  }

  void toggleTheme() {
    setDarkMode(!isDarkMode);
  }
}