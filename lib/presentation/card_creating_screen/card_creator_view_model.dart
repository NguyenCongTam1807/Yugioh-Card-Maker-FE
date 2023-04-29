import 'package:flutter/cupertino.dart';
import 'package:yugioh_card_creator/data/models/yugioh_card.dart';

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
  
  void setCardType(CardType type) {
    _currentCard.cardType = type;
    notifyListeners();
  }

  void setMonsterAttribute(MonsterAttribute attribute) {
    _currentCard.attribute = attribute;
    notifyListeners();
  }

  void setCardMonsterType(String monsterType) {
    _currentCard.monsterType = monsterType;
    notifyListeners();
  }

  String toUpperCamelCase(String s) {
    return s[0].toUpperCase()+s.toLowerCase().substring(1);
  }

  void setCardName(String name) {
    _currentCard.name = name;
    notifyListeners();
  }

  void setCardTheme(CardType type) {
    _currentCard.cardType = type;
    notifyListeners();
  }

  void setCardLevel(int level){
    _currentCard.level = level;
    notifyListeners();
  }

  void setCardDescription(String description) {
    _currentCard.description = description;
    notifyListeners();
  }

  void setCardAtk(String atk) {
    _currentCard.atk = atk;
    notifyListeners();
  }

  void setCardDef(String def) {
    _currentCard.def = def;
    notifyListeners();
  }

  void setCreatorName(String name) {
    _currentCard.creatorName = name.toUpperCase();
    notifyListeners();
  }

  void setCardImage(String url) {
    _currentCard.imagePath = url;
    notifyListeners();
  }

  void setCardEffectType(EffectType type) {
    _currentCard.effectType = type;
    notifyListeners();
  }

  String getCardTypeAssetImage() {
    String cardType = _currentCard.cardType.toString().split('.').last;
    return 'assets/images/theme/$cardType.png';
  }
}