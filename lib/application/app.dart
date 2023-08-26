import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:yugioh_card_creator/application/extensions.dart';
import 'package:yugioh_card_creator/presentation/main_screen/main_screen_view.dart';
import 'package:yugioh_card_creator/presentation/settings_screen/settings_view_model.dart';

import '../presentation/main_screen/card_creator_page/positions.dart';
import '../presentation/resources/routes.dart';
import '../presentation/resources/themes.dart';
import 'app_preferences.dart';
import 'dependency_injection.dart';

class MyApp extends StatefulWidget with GetItStatefulWidgetMixin{
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with GetItStateMixin{
  final _appPref = getIt<AppPreferences>();
  AppTheme? savedTheme;

  @override
  void initState() {
    savedTheme = _appPref.getAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(ScreenPos.cardWidthRatio, ScreenPos.cardHeightRatio),
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child) {
        final updatedTheme = watchOnly((SettingsViewModel vm) => vm.appTheme);

        return MaterialApp(
          theme: getAppTheme(updatedTheme??savedTheme.nullSafe()),
          onGenerateRoute: RouteGenerator.getRoute,
          home: MainScreenView(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}