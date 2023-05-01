import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yugioh_card_creator/application/extensions.dart';
import 'package:yugioh_card_creator/presentation/resources/styles.dart';

import 'colors.dart';
import 'const_metrics.dart';

ThemeData getAppTheme(AppTheme theme) {
  switch (theme) {
    case AppTheme.egyptian:
      return _getEgyptianTheme();
    default: return _getBewdTheme();
  }
}

ThemeData _getEgyptianTheme() {
  return ThemeData(
    primaryColor: AppColor.egyptPrimary.toColor(),
    primaryColorDark: AppColor.egyptPrimaryDark.toColor(),
    primaryColorLight: AppColor.egyptPrimaryLight.toColor(),
    accentColor: AppColor.egyptAccent.toColor(),
    appBarTheme: AppBarTheme(
        color: AppColor.egyptPrimary.toColor(),
        titleTextStyle: kCardNameTextStyle.copyWith(
          color: AppColor.textColor.toColor()
        ),
      actionsIconTheme: IconThemeData(
        color: AppColor.egyptIconColor.toColor(),
        size: ConstSizes.s55.sp,
          shadows: [
            BoxShadow(
              color: AppColor.egyptIconBorder.toColor(),
              spreadRadius: ConstSizes.s25.sp,
              blurRadius: ConstSizes.s25.sp,
            )
          ]
      )
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: AppColor.egyptIconColor.toColor(),
      )
    ),
    shadowColor: AppColor.editButtonShadowColor.toColor(),
  );
}

ThemeData _getBewdTheme() {
  return ThemeData();
}

enum AppTheme {
  egyptian, blueEyesWhiteDragon,
}