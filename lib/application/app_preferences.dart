import 'package:shared_preferences/shared_preferences.dart';
import 'package:yugioh_card_creator/application/extensions.dart';

import '../presentation/resources/map_key.dart';
import '../presentation/resources/themes.dart';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  void setAppTheme(AppTheme theme) {
    _sharedPreferences.setString(MapKey.theme, theme.getValue());
  }

  AppTheme getAppTheme() {
    return _sharedPreferences.getString(MapKey.theme).nullSafe().toAppTheme();
  }
}