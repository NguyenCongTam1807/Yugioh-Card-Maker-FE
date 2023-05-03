import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yugioh_card_creator/application/extensions.dart';
import 'package:yugioh_card_creator/data/models/yugioh_card.dart';

import '../resources/styles.dart';

class CardCreatorViewModel extends ChangeNotifier {
  YugiohCard _currentCard = YugiohCard();
  YugiohCard get currentCard => _currentCard;
  set currentCard(card) {
    _currentCard = card;
    notifyListeners();
  }

  Size _cardSize = const Size(0,0);
  Size get cardSize => _cardSize;
  set cardSize(size) {
    _cardSize = size;
    notifyListeners();
  }

  Offset _cardOffset = const Offset(0,0);
  Offset get cardOffset => _cardOffset;
  set cardOffset(offset) {
    _cardOffset = offset;
    notifyListeners();
  }

  final defStreamController = BehaviorSubject<String>();
  final atkStreamController = BehaviorSubject<String>();
  final atkDefTextStyleStreamController = BehaviorSubject<TextStyle>();

  @override
  void dispose() {
    defStreamController.close();
    atkStreamController.close();
    atkDefTextStyleStreamController.close();
    super.dispose();
  }
  
  setCardType(CardType type) {
    _currentCard.cardType = type;
    notifyListeners();
  }

  setCardAttribute(CardAttribute attribute) {
    _currentCard.attribute = attribute;
    notifyListeners();
  }

  setCardMonsterType(String monsterType) {
    _currentCard.monsterType = monsterType;
    notifyListeners();
  }

  String toUpperCamelCase(String s) {
    return s[0].toUpperCase()+s.toLowerCase().substring(1);
  }

  setCardName(String name) {
    _currentCard.name = name;
    notifyListeners();
  }

  setCardLevel(int level){
    _currentCard.level = level;
    notifyListeners();
  }

  setCardDescription(String description) {
    _currentCard.description = description;
    notifyListeners();
  }

  setCardAtk(String atk, {TextStyle? style}) {
    if (atk.isEmpty) {
      atk = atk.checkUnknownFigure();
    }
    _currentCard.atk = atk;
    atkStreamController.sink.add(atk);
  }

  setCardDef(String def) {
    if (def.isEmpty) {
      def = def.checkUnknownFigure();
    }
    _currentCard.def =  def;
    defStreamController.sink.add(def);
  }

  setAtkDefTextStyle(TextStyle style) {
    atkDefTextStyleStreamController.add(style);
  }

  setCreatorName(String name) {
    _currentCard.creatorName = name.toUpperCase();
    notifyListeners();
  }

  setCardImage(String url) {
    _currentCard.imagePath = url;
    notifyListeners();
  }

  setCardEffectType(EffectType type) {
    _currentCard.effectType = type;
    notifyListeners();
  }
}