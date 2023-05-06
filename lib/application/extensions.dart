import 'dart:ui';

import 'package:flutter/material.dart';

import '../data/models/yugioh_card.dart';
import '../presentation/resources/defaults.dart';
import '../presentation/resources/strings.dart';
import '../presentation/resources/themes.dart';

extension NullableString on String? {
  String nullSafe() {
    return this ?? "";
  }
}

extension EmptyString on String {
  String checkUnknownFigure() {
    if (isEmpty) {
      return Strings.cardUnknownAtkDef;
    }
    return this;
  }
}

extension NullableInt on int? {
  int nullSafe() {
    return this ?? 0;
  }
}

extension NullableDouble on double? {
  double nullSafe() {
    return this ?? 0.0;
  }
}

extension NullableCardType on CardType? {
  CardType nullSafe() {
    return this ?? CardDefaults.defaultCardType;
  }
}

extension NullableCardAttribute on CardAttribute? {
  CardAttribute nullSafe() {
    return this ?? CardDefaults.defaultAttribute;
  }
}

extension NullableEffectType on EffectType? {
  EffectType nullSafe() {
    return this ?? CardDefaults.defaultEffectType;
  }
}

extension NullableColor on Color? {
  Color nullSafe() {
    return this??Colors.green;
  }
}

extension CardAttributeExtension on CardAttribute {
  String getAssetPath() {
    return 'assets/images/attribute/${toString().split('.').last}_en.png';
  }
}

extension CardTypeExtension on CardType {
  String getName() {
    final s = toString();
    final index = s.lastIndexOf('.');
    return s.substring(index+1);
  }

  String getAssetPath() {
    return 'assets/images/theme/${getName()}.png';
  }

  Color getMainColor({String alphaHex = 'ff'}) {
    return (colorMap[getName()] ?? CardDefaults.defaultCardThemeColor)
        .toColor(alphaHex: alphaHex);
  }

  Color getForegroundColor() {
    return getMainColor().computeLuminance()<0.5?Colors.white:Colors.black;
  }

  CardTypeGroup get group {
    switch (this) {
      case CardType.spell:
        return CardTypeGroup.spell;
      case CardType.trap:
        return CardTypeGroup.trap;
      default:
        return CardTypeGroup.monster;
    }
  }
}

extension EffectTypeExtension on EffectType {
  String getName() {
    final s = toString();
    final index = s.lastIndexOf('.');
    return s.substring(index+1);
  }

  String getAssetPath() {
    return 'assets/images/icons/${getName()}.png';
  }
}

extension HexColor on String {
  Color toColor({String alphaHex = 'FF'}) {
    String hexInt = replaceFirst('#', '');
    if (hexInt.length == 6) {
      hexInt = '$alphaHex$hexInt';
    }
    return Color(int.parse(hexInt, radix: 16));
  }
}

extension NullableArrowList on List<bool>? {
  List<bool> nullSafe() {
    return this??CardDefaults.defaultLinkArrows;
  }
}

extension ListBoolExtension on List<bool> {
  int getRating() {
    return where((element) => element).length;
  }
}

extension AppThemeExtension on AppTheme {
  String getName() {
    final value = getValue();
    String res = value[0].toUpperCase();
    for (int i = 1;i < getValue().length; i++) {
      if (value[i] == value[i].toUpperCase()) {
        res+=' ';
      }
      res+=value[i];
    }
    return res;
  }

  String getValue() {
    final s = toString();
    final index = s.lastIndexOf('.');
    return s.substring(index+1);
  }

  String getAssetPath() {
    return 'assets/images/app_theme_previews/${getValue()}.png';
  }
}