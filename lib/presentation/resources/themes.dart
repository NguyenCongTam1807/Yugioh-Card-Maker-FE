import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yugioh_card_creator/application/extensions.dart';
import 'package:yugioh_card_creator/presentation/resources/styles.dart';

import 'colors.dart';
import 'layout.dart';
import 'map_key.dart';

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
      return _getTheme(AppColor.streetTheme);
    default:
      return _getTheme(AppColor.egyptTheme);
  }
}

ThemeData _getTheme(Map<String, Color> colorMap) {
  return ThemeData(
      primaryColor: colorMap[MapKey.appBar],
      primaryColorLight: colorMap[MapKey.modalBottomSheetStart],
      primaryColorDark: colorMap[MapKey.modalBottomSheetEnd],
      colorScheme: ColorScheme.light(
        primary: colorMap[MapKey.mainFieldBody1].nullSafe(),
        secondary: colorMap[MapKey.mainFieldBody2].nullSafe(),
        tertiary: colorMap[MapKey.popupMenuBackground],
        primaryContainer: colorMap[MapKey.secondaryScaffoldBody1], //two colors of the secondary scaffold body
        secondaryContainer: colorMap[MapKey.secondaryScaffoldBody2],
        onPrimaryContainer: colorMap[MapKey.secondaryScaffoldText].nullSafe(), // text color of the secondary scaffold body
      ),
      appBarTheme: AppBarTheme(
          color: colorMap[MapKey.appBar],
          titleTextStyle:
          kCardNameTextStyle.copyWith(color: colorMap[MapKey.appBarText]),
          iconTheme: IconThemeData(
              color: colorMap[MapKey.icon],
              size: ScreenLayout.smallIconSize,
              shadows: [
                BoxShadow(
                  color: colorMap[MapKey.iconShadow].nullSafe(),
                  spreadRadius: ScreenLayout.bigIconShadowRadius,
                  blurRadius: ScreenLayout.bigIconShadowRadius,
                )
              ]
          ),
          actionsIconTheme: IconThemeData(
              color: colorMap[MapKey.icon],
              size: ScreenLayout.bigIconSize,
              shadows: [
                BoxShadow(
                  color: colorMap[MapKey.iconShadow].nullSafe(),
                  spreadRadius: ScreenLayout.bigIconShadowRadius,
                  blurRadius: ScreenLayout.bigIconShadowRadius,
                )
              ])),
      dialogTheme: DialogTheme(
        elevation: 10.0,
        backgroundColor: colorMap[MapKey.dialog1],
        surfaceTintColor: colorMap[MapKey.dialog2],
        iconColor: colorMap[MapKey.dialogButton],
        titleTextStyle: TextStyle(
            color: colorMap[MapKey.dialogButtonText],
        ),
        contentTextStyle: TextStyle(
          color: colorMap[MapKey.dialogContent]
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorMap[MapKey.icon],
      ),
      iconTheme:
      IconThemeData(color: colorMap[MapKey.icon], shadows: [
        BoxShadow(
          color: colorMap[MapKey.iconShadow].nullSafe(),
          spreadRadius: ScreenLayout.smallIconShadowRadius,
          blurRadius: ScreenLayout.smallIconShadowRadius,
        ),
      ]),
      iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: colorMap[MapKey.icon],
          )),
      listTileTheme: ListTileThemeData(
          iconColor: colorMap[MapKey.icon]
      ),
      shadowColor: colorMap[MapKey.fieldIconShadow],
      splashColor: colorMap[MapKey.splash],
      dividerTheme: DividerThemeData(
        color: colorMap[MapKey.divider],
        thickness: 3.sp,
      )
  );
}