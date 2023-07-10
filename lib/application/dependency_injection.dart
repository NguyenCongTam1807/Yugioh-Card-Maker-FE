import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yugioh_card_creator/application/app_preferences.dart';
import 'package:yugioh_card_creator/data/network/dio_factory.dart';
import 'package:yugioh_card_creator/presentation/main_screen/main_screen_view_model.dart';
import 'package:yugioh_card_creator/presentation/settings_screen/settings_view_model.dart';

import '../presentation/main_screen/card_creator_page/card_creator_view_model.dart';

final getIt = GetIt.I;

Future<void> initAppModule() async {
  final sharedPref = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() =>  sharedPref);
  getIt.registerLazySingleton<AppPreferences>(() =>  AppPreferences(getIt()));
  getIt.registerLazySingleton<DioFactory>(() => const DioFactory());
  final dio = getIt<DioFactory>().getDio();
  getIt.registerLazySingleton<ImagePicker>(() => ImagePicker());
  getIt.registerLazySingleton<MainScreenViewModel>(() => MainScreenViewModel());
  getIt.registerLazySingleton<CardCreatorViewModel>(() => CardCreatorViewModel());
  getIt.registerLazySingleton<SettingsViewModel>(() => SettingsViewModel(getIt()));
}