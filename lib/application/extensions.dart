import 'dart:ui';

import '../data/models/yugioh_card.dart';
import '../presentation/resources/card_defaults.dart';
import '../presentation/resources/strings.dart';

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

extension CardAttributeExtension on CardAttribute {
  String getAssetPath() {
    return 'assets/images/attribute/${toString().split('.').last}_en.png';
  }
}

extension CardTypeExtension on CardType {
  String getName() {
    return toString().split('.').last;
  }

  String getAssetPath() {
    return 'assets/images/theme/${getName()}.png';
  }

  Color getMainColor() {
    const colorList = {
      'normal': '#fde68a',
      'spell': '#1d9e74',
      'trap': '#bc5a84',
      'ritual': '#9db5cc',
      'effect': '#ff8b53',
      'fusion': '#a086b7',
      'token': '#c0c0c0',
      'synchro': '#cccccc',
      'xyz': '#000000',
      'link': '#00008b'
    };
    return (colorList[getName()] ?? CardDefaults.defaultCardThemeColor)
        .toColor(alphaHex: 'bf');
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
    return toString().split('.').last;
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
