import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../presentation/card_creator_screen/card_creator_view.dart';
import '../presentation/card_creator_screen/positions.dart';
import '../presentation/resources/routes.dart';
import '../presentation/resources/themes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(ScreenPos.cardWidthRatio, ScreenPos.cardHeightRatio),
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          theme: getAppTheme(AppTheme.egyptian),
          onGenerateRoute: RouteGenerator.getRoute,
          home: const CardCreatorView(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}