

import '../../presentation/resources/card_defaults.dart';
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
    this.attribute = CardDefaults.defaultAttribute,
    this.imagePath = CardDefaults.defaultCardImage,
    this.monsterType = Strings.defaultMonsterType,
    this.description = Strings.defaultDescription,
    this.atk = Strings.defaultAtk,
    this.def = Strings.defaultDef,
    this.creatorName = Strings.defaultCreatorName,
    this.cardType = CardDefaults.defaultCardType,
    this.level = CardDefaults.defaultCardLevel,
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
  spell,
  trap,
  ritual,
  effect,
  fusion,
  token,
  synchro,
  xyz,
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
