import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yugioh_card_creator/application/extensions.dart';
import 'package:yugioh_card_creator/presentation/resources/styles.dart';

import 'colors.dart';
import 'layout.dart';

enum AppTheme {
  ancientEgypt,
  blueEyesWhiteDragon,
  urbanStreet,
}

ThemeData getAppTheme(AppTheme theme) {
  switch (theme) {
    case AppTheme.ancientEgypt:
      return _getTheme(AppColor.egyptTheme);
    case AppTheme.blueEyesWhiteDragon:
      return _getTheme(AppColor.bewdTheme);
    case AppTheme.urbanStreet:
      return _getTheme(AppColor.bewdTheme);
    default:
      return _getTheme(AppColor.egyptTheme);
  }
}

ThemeData _getTheme(Map<String, Color> colorMap) {
  return ThemeData(
    primaryColor: colorMap[appBar],
      primaryColorLight: colorMap[modalBottomSheetStart],
      primaryColorDark: colorMap[modalBottomSheetEnd],
    colorScheme: ColorScheme.light(
      primary: colorMap[mainFieldBody1].nullSafe(),
      secondary: colorMap[mainFieldBody2].nullSafe(),
      tertiary: colorMap[popupMenuBackground],
      primaryContainer: colorMap[secondaryScaffoldBody1], //two colors of the secondary scaffold body
      secondaryContainer: colorMap[secondaryScaffoldBody2],
      onPrimaryContainer: colorMap[secondaryScaffoldText].nullSafe(), // text color of the secondary scaffold body
    ),
    appBarTheme: AppBarTheme(
        color: colorMap[appBar],
        titleTextStyle:
        kCardNameTextStyle.copyWith(color: Colors.black),
        iconTheme: IconThemeData(
            color: colorMap[icon],
            size: ScreenLayout.smallIconSize,
            shadows: [
              BoxShadow(
                color: colorMap[iconShadow].nullSafe(),
                spreadRadius: ScreenLayout.bigIconShadowRadius,
                blurRadius: ScreenLayout.bigIconShadowRadius,
              )
            ]
        ),
        actionsIconTheme: IconThemeData(
            color: colorMap[icon],
            size: ScreenLayout.bigIconSize,
            shadows: [
              BoxShadow(
                color: colorMap[iconShadow].nullSafe(),
                spreadRadius: ScreenLayout.bigIconShadowRadius,
                blurRadius: ScreenLayout.bigIconShadowRadius,
              )
            ])),
    iconTheme:
    IconThemeData(color: colorMap[icon], shadows: [
      BoxShadow(
        color: colorMap[iconShadow].nullSafe(),
        spreadRadius: ScreenLayout.smallIconShadowRadius,
        blurRadius: ScreenLayout.smallIconShadowRadius,
      ),
    ]),
    iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: colorMap[icon],
        )),
    listTileTheme: ListTileThemeData(
        iconColor: colorMap[icon]
    ),
    shadowColor: colorMap[fieldIconShadow],
    splashColor: colorMap[splash],
    dividerTheme: DividerThemeData(
      color: AppColor.egyptSecondary,
      thickness: 3.sp,
    )
  );
}