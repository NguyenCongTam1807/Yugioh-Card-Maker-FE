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
    //Scaffold Background gradient
    colorScheme: const ColorScheme.light(
      primary: AppColor.egyptFieldEnds,
      secondary: AppColor.egyptFieldMiddle
    ),
    appBarTheme: AppBarTheme(
        color: AppColor.egyptPrimary,
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
  return ThemeData(
    primaryColor: AppColor.bewdPrimary,
    primaryColorDark: AppColor.bewdPrimaryDark,
    primaryColorLight: AppColor.bewdPrimaryLight,
    accentColor: AppColor.bewdAccent,
    //Scaffold Background gradient
    colorScheme: const ColorScheme.light(
        primary: AppColor.bewdFieldEnds,
        secondary: AppColor.bewdFieldMiddle,
        tertiary: AppColor.bewdMenuBackground // menu background
    ),
    appBarTheme: AppBarTheme(
        color: AppColor.bewdPrimary,
        titleTextStyle:
        kCardNameTextStyle.copyWith(color: AppColor.textColor),
        actionsIconTheme: IconThemeData(
            color: AppColor.bewdIconColor,
            size: ScreenLayout.bigIconSize,
            shadows: [
              BoxShadow(
                color: AppColor.bewdIconBorder,
                spreadRadius: ScreenLayout.bigIconShadowRadius,
                blurRadius: ScreenLayout.bigIconShadowRadius,
              )
            ])),
    iconTheme:
    IconThemeData(color: AppColor.bewdIconColor, shadows: [
      BoxShadow(
        color: AppColor.bewdIconBorder,
        spreadRadius: ScreenLayout.smallIconShadowRadius,
        blurRadius: ScreenLayout.smallIconShadowRadius,
      ),
    ]),
    iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: AppColor.bewdIconColor,
        )),
    shadowColor: AppColor.bewdSecondary,
    splashColor: AppColor.bewdAccent,
    dividerColor: AppColor.bewdSecondary,
  );
}

enum AppTheme {
  egyptian,
  blueEyesWhiteDragon,
}
