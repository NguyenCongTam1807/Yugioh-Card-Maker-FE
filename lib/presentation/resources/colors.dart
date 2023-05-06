import 'dart:ui';

import 'package:flutter/material.dart';

const appBar = 'appBar';
const appBarText = 'appBarText';
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
  // Ancient Egypt theme
  static const Color _egyptPrimary = Color(0xFFcab146);
  static const Color _egyptPrimaryDark = Color(0xFFbd7b29);
  static const Color _egyptPrimaryLight = Color(0xFFd0d759);
  static const Color _egyptSecondary = Color(0xFF823917);
  static const Color _egyptSecondaryDark = Color(0xFF540d00);
  static const Color _egyptSecondaryLight = Color(0xFFbf7753);
  static const Color _egyptAccent = Color(0xFF68CC87);
  static const Color _egyptAccentDark = Color(0xFF00A54C);
  static const Color _egyptAccentLight = Color(0xFFE5F6EA);
  static const Color _egyptTextColor = Color(0xFF000000);
  static const Color _egyptIconColor = Color(0xFFfadf9b);
  static const Color _egyptIconShadow = Color(0xFF212607);

  static const Color _egyptFieldEnds = Color(0x7F68CC87); // lowered opacity Accent
  static const Color _egyptFieldMiddle =
  Color(0x7Fd0d759); // lowered opacity PrimaryLight
  static const Color _egyptMenuBackground =
  Color(0x9F540d00); // lowered opacity SecondaryDark
  static const Color _egyptSettingsStart = Color(0xCFd0d759);
  static const Color _egyptSettingsEnd = Color(0xCF823917);
  //////Mapping of above colors
  static const Map<String, Color> egyptTheme = {
    appBar: _egyptPrimary,
    appBarText: Colors.black,
    modalBottomSheetStart: _egyptPrimary,
    modalBottomSheetEnd: _egyptPrimaryDark,
    icon: _egyptIconColor,
    iconShadow: _egyptIconShadow,
    splash: _egyptAccent,
    fieldIconShadow: _egyptSecondary,
    mainFieldBody1: _egyptFieldEnds,
    mainFieldBody2: _egyptFieldMiddle,
    popupMenuBackground: _egyptMenuBackground,
    secondaryScaffoldBody1: _egyptSettingsStart,
    secondaryScaffoldBody2: _egyptSettingsEnd,
    secondaryScaffoldText: _egyptTextColor,
    divider: _egyptSecondary
  };

  // Blue eyes white dragon theme
  static const Color _bewdPrimary = Color(0xFF96AEC6);
  static const Color _bewdPrimaryDark = Color(0xFF6A89A6);
  static const Color _bewdPrimaryLight = Color(0xFFE8F1FF);
  static const Color _bewdSecondary = Color(0xFF224980);
  static const Color _bewdSecondaryDark = Color(0xFF0A3060);
  static const Color _bewdSecondaryLight = Color(0xFF91A1BC);
  static const Color _bewdAccent = Color(0xFFDe9169);
  static const Color _bewdAccentDark = Color(0xFFC24D00);
  static const Color _bewdAccentLight = Color(0xFFF9E1DB);
  static const Color _bewdTextColor = Color(0xFF00E0FC);
  static const Color _bewdIconColor = Color(0xFF030730);
  static const Color _bewdIconShadow = Color(0xFFc1def2);

  static const Color _bewdFieldEnds = Color(0x806A89A6);
  static const Color _bewdFieldMiddle = Color(0x80DE9169);
  static const Color _bewdMenuBackground = Color(0x9F0A3060);
  static const Color _bewdSettingsStart = Color(0xAFE8F1FF);
  static const Color _bewdSettingsEnd = Color(0xAF06CE51);

  static const Map<String, Color> bewdTheme = {
    appBar: _bewdPrimary,
    appBarText: Colors.black,
    modalBottomSheetStart: _bewdPrimary,
    modalBottomSheetEnd: _bewdPrimaryDark,
    icon: _bewdIconColor,
    iconShadow: _bewdIconShadow,
    splash: _bewdAccent,
    fieldIconShadow: _bewdSecondary,
    mainFieldBody1: _bewdFieldEnds,
    mainFieldBody2: _bewdFieldMiddle,
    popupMenuBackground: _bewdMenuBackground,
    secondaryScaffoldBody1: _bewdSettingsStart,
    secondaryScaffoldBody2: _bewdSettingsEnd,
    secondaryScaffoldText: _bewdTextColor,
    divider: _bewdSecondary
  };

  // Urban street theme
  static const Color _streetPrimary = Color(0xFF5A6E82);
  static const Color _streetPrimaryDark = Color(0xFF3B4755);
  static const Color _streetPrimaryLight = Color(0xFF94A4B5);
  static const Color _streetSecondary = Color(0xFFe8b34d);
  static const Color _streetSecondaryDark = Color(0xFFAB7F3F);
  static const Color _streetSecondaryLight = Color(0xFFFFDE56);
  static const Color _streetAccent = Color(0xFFe4f0f6);
  static const Color _streetAccentDark = Color(0xFF4AAEE3);
  static const Color _streetAccentLight = Color(0xFFFFFFFF);
  static const Color _streetTextColor = Color(0xFF246dca);
  static const Color _streetIconColor = Color(0xFF78b6ed);
  static const Color _streetIconShadow = Color(0xFFe7eff7);

  static const Color _streetFieldEnds = Color(0x805A6E82);
  static const Color _streetFieldMiddle = Color(0x80e4f0f6);
  static const Color _streetMenuBackground = Color(0x9FAB7F3F);
  static const Color _streetSettingsStart = Color(0xAF94A4B5);
  static const Color _streetSettingsEnd = Color(0xAF3B4755);

  static const Map<String, Color> streetTheme = {
    appBar: _streetPrimary,
    appBarText: Colors.white,
    modalBottomSheetStart: _streetPrimary,
    modalBottomSheetEnd: _streetPrimaryDark,
    icon: _streetIconColor,
    iconShadow: _streetIconShadow,
    splash: _streetAccent,
    fieldIconShadow: _streetSecondary,
    mainFieldBody1: _streetFieldEnds,
    mainFieldBody2: _streetFieldMiddle,
    popupMenuBackground: _streetMenuBackground,
    secondaryScaffoldBody1: _streetSettingsStart,
    secondaryScaffoldBody2: _streetSettingsEnd,
    secondaryScaffoldText: _streetTextColor,
    divider: _streetSecondary
  };
}
