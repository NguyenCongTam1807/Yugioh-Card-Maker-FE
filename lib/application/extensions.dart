
import '../presentation/card_creating_screen/card_constants.dart';
import '../data/models/yugioh_card.dart';

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
    return this??CardConstants.defaultCardType;
  }
}

extension NullableMonsterAttribute on MonsterAttribute? {
  MonsterAttribute nullSafe() {
    return this??CardConstants.defaultAttribute;
  }
}

extension MonsterAttributeExtension on MonsterAttribute {
  String getAssetPath() {
    return 'assets/images/attribute/${toString().split('.').last}_en.png';
  }
}