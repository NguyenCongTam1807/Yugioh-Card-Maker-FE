import 'package:flutter/material.dart';
import 'package:yugioh_card_creator/application/app_preferences.dart';

import '../resources/themes.dart';

class SettingsViewModel extends ChangeNotifier {
  final AppPreferences _appPreferences;
  SettingsViewModel(this._appPreferences);

  AppTheme? appTheme;

  void setAppTheme(AppTheme theme) {
    if (appTheme == null || appTheme != theme) {
      appTheme = theme;
      notifyListeners();

      _appPreferences.setAppTheme(theme);
    }
  }
}