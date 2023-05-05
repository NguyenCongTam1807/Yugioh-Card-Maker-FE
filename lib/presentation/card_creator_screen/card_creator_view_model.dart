import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yugioh_card_creator/application/extensions.dart';
import 'package:yugioh_card_creator/data/models/yugioh_card.dart';


class CardCreatorViewModel extends ChangeNotifier {
  YugiohCard currentCard = YugiohCard();
  Size cardSize = const Size(0,0);
  Offset cardOffset = const Offset(0,0);
  int cardDescMaxLine = 0;

  final cardTypeGroupStreamController = BehaviorSubject<CardTypeGroup>();
  final defStreamController = BehaviorSubject<String>();
  final atkStreamController = BehaviorSubject<String>();
  final atkDefTextStyleStreamController = BehaviorSubject<TextStyle>();

  void init() {
    cardTypeGroupStreamController.add(currentCard.cardType.nullSafe().group);
  }

  @override
  void dispose() {
    cardTypeGroupStreamController.close();
    defStreamController.close();
    atkStreamController.close();
    atkDefTextStyleStreamController.close();
    super.dispose();
  }
  
  setCardType(CardType type) {
    currentCard.cardType = type;
    cardTypeGroupStreamController.add(currentCard.cardType.nullSafe().group);
    notifyListeners();
  }

  setCardAttribute(CardAttribute attribute) {
    currentCard.attribute = attribute;
    notifyListeners();
  }

  setCardMonsterType(String monsterType) {
    currentCard.monsterType = monsterType;
    notifyListeners();
  }

  setCardName(String name) {
    currentCard.name = name;
    notifyListeners();
  }

  setCardLevel(int level){
    currentCard.level = level;
    notifyListeners();
  }

  setCardDescription(String description) {
    currentCard.description = description;
    notifyListeners();
  }

  setCardDescMaxLine(int maxLine) {
    cardDescMaxLine = maxLine;
  }

  setCardAtk(String atk, {TextStyle? style}) {
    if (atk.isEmpty) {
      atk = atk.checkUnknownFigure();
    }
    currentCard.atk = atk;
    atkStreamController.sink.add(atk);
  }

  setCardDef(String def) {
    if (def.isEmpty) {
      def = def.checkUnknownFigure();
    }
    currentCard.def =  def;
    defStreamController.sink.add(def);
  }

  setAtkDefTextStyle(TextStyle style) {
    atkDefTextStyleStreamController.add(style);
  }

  setCreatorName(String name) {
    currentCard.creatorName = name.toUpperCase();
    notifyListeners();
  }

  setCardImage(String url) {
    currentCard.imagePath = url;
    notifyListeners();
  }

  setEffectType(EffectType type) {
    currentCard.effectType = type;
    notifyListeners();
  }
}