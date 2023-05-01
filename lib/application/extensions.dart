
import 'dart:ui';

import 'package:yugioh_card_creator/presentation/resources/colors.dart';

import '../presentation/card_creating_screen/positions.dart';
import '../data/models/yugioh_card.dart';
import '../presentation/resources/card_defaults.dart';

extension NullableString on String? {
  String nullSafe() {
    return this??"";
  }
}

extension NullableInt on int? {
  int nullSafe() {
    return this??0;
  }
}

extension NullableCardType on CardType? {
  CardType nullSafe() {
    return this??CardDefaults.defaultCardType;
  }
}

extension NullableCardAttribute on CardAttribute? {
  CardAttribute nullSafe() {
    return this??CardDefaults.defaultAttribute;
  }
}

extension CardAttributeExtension on CardAttribute {
  String getAssetPath() {
    return 'assets/images/attribute/${toString().split('.').last}_en.png';
  }
}

extension HexColor on String {
  Color toColor() {
    String hexInt = replaceFirst('#', '');
    if (hexInt.length == 6) {
      hexInt = 'FF$hexInt';
    }
    return Color(int.parse(hexInt, radix: 16));
  }
}