

import '../../presentation/resources/images.dart';
import '../../presentation/resources/strings.dart';

class YugiohCard {
  int? id;
  String? name;
  CardAttribute? attribute;
  String? imagePath;
  String? monsterType;
  String? description;
  String? atk;
  String? def;
  String? creatorName;
  CardType? cardType;
  int? level;
  EffectType? effectType;

  YugiohCard({
    this.id,
    this.name = Strings.defaultCardName,
    this.attribute = CardAttribute.light,
    this.imagePath = ImagePath.defaultCardImage,
    this.monsterType = Strings.defaultMonsterType,
    this.description = Strings.defaultDescription,
    this.atk = Strings.defaultAtk,
    this.def = Strings.defaultDef,
    this.creatorName = Strings.defaultCreatorName,
    this.cardType = CardType.normal,
    this.level = 6,
    this.effectType,
  });
}

enum CardAttribute {
  dark,
  light,
  earth,
  wind,
  fire,
  water,
  divine,
  spell,
  trap
}

enum CardType {
  normal,
  effect,
  fusion,
  ritual,
  synchro,
  token,
  xyz,
  spell,
  trap,
  link
}

enum EffectType {
  continuous,
  counter,
  equip,
  field,
  quickPlay,
  ritual,
  none,
}
