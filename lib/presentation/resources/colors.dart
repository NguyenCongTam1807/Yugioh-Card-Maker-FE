import 'dart:ui';

import 'package:flutter/material.dart';

const appBar = 'appBar';
const modalBottomSheetStart = 'modalBottomSheetStart';
const modalBottomSheetEnd = 'modalBottomSheetEnd';
const icon = 'icon';
const iconShadow = 'iconShadow';
const splash = 'splash';
const fieldIconShadow = 'fieldIconShadow';
const mainFieldBody1 = 'mainFieldBody1';
const mainFieldBody2 = 'mainFieldBody2';
const popupMenuBackground = 'popupMenuBackground';
const secondaryScaffoldBody1 = 'secondaryScaffoldBody1';
const secondaryScaffoldBody2 = 'secondaryScaffoldBody2';
const secondaryScaffoldText = 'secondaryScaffoldText';
const divider = 'divider';

class AppColor {
  //Egyptian theme
  static const egyptPrimary = Color(0xFFcab146);
  static const egyptPrimaryDark = Color(0xFFbd7b29);
  static const egyptPrimaryLight = Color(0xFFd0d759);
  static const egyptSecondary = Color(0xFF823917);
  static const egyptSecondaryDark = Color(0xFF540d00);
  static const egyptSecondaryLight = Color(0xFFbf7753);
  static const egyptAccent = Color(0xFF68CC87);
  static const egyptAccentDark = Color(0xFF00A54C);
  static const egyptAccentLight = Color(0xFFE5F6EA);
  static const egyptTextColor = Color(0xFF000000);
  static const egyptIconColor = Color(0xFFfadf9b);
  static const egyptIconShadow = Color(0xFF212607);

  static const egyptFieldEnds = Color(0x7F68CC87); // lowered opacity Accent
  static const egyptFieldMiddle =
      Color(0x7Fd0d759); // lowered opacity PrimaryLight
  static const egyptMenuBackground =
      Color(0x9F540d00); // lowered opacity SecondaryDark
  static const egpytSettingsStart = Color(0xCFd0d759);
  static const egpytSettingsEnd = Color(0xCF823917);
  //////Mapping of above colors
  static const egyptTheme = {
    appBar: egyptPrimary,
    modalBottomSheetStart: egyptPrimary,
    modalBottomSheetEnd: egyptPrimaryDark,
    icon: egyptIconColor,
    iconShadow: egyptIconShadow,
    splash: egyptAccent,
    fieldIconShadow: egyptSecondary,
    mainFieldBody1: egyptFieldEnds,
    mainFieldBody2: egyptFieldMiddle,
    popupMenuBackground: egyptMenuBackground,
    secondaryScaffoldBody1: egpytSettingsStart,
    secondaryScaffoldBody2: egpytSettingsEnd,
    secondaryScaffoldText: egyptTextColor,
    divider: egyptSecondary
  };

  //Blue eyes white dragon theme
  static const bewdPrimary = Color(0xFF96AEC6);
  static const bewdPrimaryDark = Color(0xFF6A89A6);
  static const bewdPrimaryLight = Color(0xFFE8F1FF);
  static const bewdSecondary = Color(0xFF224980);
  static const bewdSecondaryDark = Color(0xFF0A3060);
  static const bewdSecondaryLight = Color(0xFF91A1BC);
  static const bewdAccent = Color(0xFFDe9169);
  static const bewdAccentDark = Color(0xFFC24D00);
  static const bewdAccentLight = Color(0xFFF9E1DB);
  static const bewdTextColor = Color(0xFF00E0FC);
  static const bewdIconColor = Color(0xFF030730);
  static const bewdIconShadow = Color(0xFFc1def2);

  static const bewdFieldEnds = Color(0x806A89A6);
  static const bewdFieldMiddle = Color(0x80DE9169);
  static const bewdMenuBackground = Color(0x9F0A3060);
  static const bewdSettingsStart = Color(0xAF06CE51);
  static const bewdSettingsEnd = Color(0xAF823917);

  static const bewdTheme = {
    appBar: bewdPrimary,
    modalBottomSheetStart: bewdPrimary,
    modalBottomSheetEnd: bewdPrimaryDark,
    icon: bewdIconColor,
    iconShadow: bewdIconShadow,
    splash: bewdAccent,
    fieldIconShadow: bewdSecondary,
    mainFieldBody1: bewdFieldEnds,
    mainFieldBody2: bewdFieldMiddle,
    popupMenuBackground: bewdMenuBackground,
    secondaryScaffoldBody1: bewdPrimaryLight,
    secondaryScaffoldBody2: bewdSecondary,
    secondaryScaffoldText: bewdTextColor,
    divider: bewdSecondary
  };
}
