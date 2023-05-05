import '../../presentation/resources/card_defaults.dart';
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
    this.effectType = EffectType.normal,
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

enum CardTypeGroup {
  monster,
  spell,
  trap
}

enum EffectType {
  normal,
  continuous,
  counter,
  equip,
  field,
  quickPlay,
  ritual,
}

const spellCardTypes = [
  EffectType.normal,
  EffectType.continuous,
  EffectType.equip,
  EffectType.field,
  EffectType.ritual,
  EffectType.quickPlay,
];

const trapCardTypes = [
  EffectType.normal,
  EffectType.continuous,
  EffectType.counter,
];
