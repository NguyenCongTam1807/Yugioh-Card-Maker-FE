import 'package:flutter/material.dart';
import 'package:yugioh_card_creator/presentation/resources/defaults.dart';

import '../resources/themes.dart';

class SettingsViewModel extends ChangeNotifier {
  AppTheme appTheme = AppDefaults.defaultAppTheme;

  void setAppTheme(AppTheme theme) {
    if (appTheme != theme) {
      appTheme = theme;
      notifyListeners();
    }
  }
}