import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:yugioh_card_creator/presentation/settings_screen/settings_view_model.dart';


import '../presentation/card_creator_screen/card_creator_view.dart';
import '../presentation/card_creator_screen/positions.dart';
import '../presentation/resources/routes.dart';
import '../presentation/resources/themes.dart';

class MyApp extends StatelessWidget with GetItMixin{
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(ScreenPos.cardWidthRatio, ScreenPos.cardHeightRatio),
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child) {
        final appTheme = watchOnly((SettingsViewModel vm) => vm.appTheme);

        return MaterialApp(
          theme: getAppTheme(appTheme),
          onGenerateRoute: RouteGenerator.getRoute,
          home: const CardCreatorView(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}