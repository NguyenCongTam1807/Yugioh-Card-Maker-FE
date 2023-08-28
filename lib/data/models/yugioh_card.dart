import 'dart:ui';

import '../../presentation/resources/defaults.dart';
import '../../presentation/resources/strings.dart';

class YugiohCard {
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
  List<bool>? linkArrows;
  String? storageKey;

  YugiohCard({
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
    this.linkArrows = CardDefaults.defaultLinkArrows,
    this.storageKey,
  });

  factory YugiohCard.fromJson(Map<String, dynamic> json) {
    final attribute = CardAttribute.values.firstWhere((element) => element.toString() == json['attribute']);
    final cardType = CardType.values.firstWhere((element) => element.toString() == json['cardType']);
    final effectType = EffectType.values.firstWhere((element) => element.toString() == json['effectType']);
    final linkArrows = <bool>[];
    final linkArrowsString = json['linkArrows'] as String;
    for (int i = 0; i<linkArrowsString.length; i++) {
      linkArrows.add(linkArrowsString[i] == "1");
    }
    return YugiohCard(
      name: json['name'],
      attribute: attribute,
      imagePath: json['imagePath'],
      monsterType: json['monsterType'],
      description: json['description'],
      atk: json['atk'],
      def: json['def'],
      creatorName: json['creatorName'],
      cardType: cardType,
      level: json['level'],
      effectType: effectType,
      linkArrows: linkArrows,
      storageKey: json['storageKey'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['attribute'] = attribute.toString();
    data['imagePath'] = imagePath;
    data['monsterType'] = monsterType;
    data['description'] = description;
    data['atk'] = atk;
    data['def'] = def;
    data['creatorName'] = creatorName;
    data['cardType'] = cardType.toString();
    data['level'] = level;
    data['effectType'] = effectType.toString();
    var arrowsString = "";
    linkArrows?.forEach((linkEnabled) =>arrowsString+=linkEnabled? "1":"0");
    data['linkArrows'] = arrowsString;
    data['storageKey'] = storageKey;
    return data;
  }
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

const colorMap = {
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

class LinkArrow {
  final int index;
  final String imagePath;
  final List<Offset> vertices;
  final Offset offset;

  const LinkArrow({required this.index, required this.imagePath, required this.vertices, required this.offset});
}
