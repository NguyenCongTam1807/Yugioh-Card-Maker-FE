import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../presentation/card_creating_screen/card_creator_view.dart';
import '../presentation/card_creating_screen/card_constants.dart';
import '../presentation/resources/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(CardConstants.cardWidthRatio, CardConstants.cardHeightRatio),
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          onGenerateRoute: RouteGenerator.getRoute,
          home: CardCreatorView(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}