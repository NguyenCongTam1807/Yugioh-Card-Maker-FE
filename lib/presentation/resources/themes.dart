import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yugioh_card_creator/application/extensions.dart';
import 'package:yugioh_card_creator/presentation/resources/styles.dart';

import 'colors.dart';
import 'layout.dart';

ThemeData getAppTheme(AppTheme theme) {
  switch (theme) {
    case AppTheme.egyptian:
      return _getEgyptianTheme();
    default:
      return _getBewdTheme();
  }
}

ThemeData _getEgyptianTheme() {
  return ThemeData(
    primaryColor: AppColor.egyptPrimary,
    primaryColorDark: AppColor.egyptPrimaryDark,
    primaryColorLight: AppColor.egyptPrimaryLight,
    accentColor: AppColor.egyptAccent,
    appBarTheme: AppBarTheme(
        color: AppColor.egyptPrimaryLight,
        titleTextStyle:
            kCardNameTextStyle.copyWith(color: AppColor.textColor),
        actionsIconTheme: IconThemeData(
            color: AppColor.egyptIconColor,
            size: ScreenLayout.bigIconSize,
            shadows: [
              BoxShadow(
                color: AppColor.egyptIconBorder,
                spreadRadius: ScreenLayout.bigIconShadowRadius,
                blurRadius: ScreenLayout.bigIconShadowRadius,
              )
            ])),
    iconTheme:
        IconThemeData(color: AppColor.egyptIconColor, shadows: [
      BoxShadow(
        color: AppColor.egyptIconBorder,
        spreadRadius: ScreenLayout.smallIconShadowRadius,
        blurRadius: ScreenLayout.smallIconShadowRadius,
      ),
    ]),
    iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
      foregroundColor: AppColor.egyptIconColor,
    )),
    shadowColor: AppColor.egyptSecondary,
    splashColor: AppColor.egyptAccent,
    dividerColor: AppColor.egyptSecondary,

  );
}

ThemeData _getBewdTheme() {
  return ThemeData();
}

enum AppTheme {
  egyptian,
  blueEyesWhiteDragon,
}
