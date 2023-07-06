import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yugioh_card_creator/application/extensions.dart';
import 'package:yugioh_card_creator/data/models/yugioh_card.dart';

import 'help_step.dart';

class CardCreatorViewModel extends ChangeNotifier {
  YugiohCard currentCard = YugiohCard();
  Size cardSize = const Size(0, 0);
  Offset cardOffset = const Offset(0, 0);
  int cardDescMaxLine = 0;
  int linkRating = 0;
  GlobalKey cardKey = GlobalKey();
  Map<int, String> helpItemNameMap = {
    HelpStep.saveCardButton: 'SaveCardButton',
    HelpStep.cardTypeButton: 'CardTypeButton',
    HelpStep.cardImageButton: 'CardImageButton',
    HelpStep.cardName: 'CardName',
    HelpStep.cardAttribute: 'CardAttributeIcon',
    HelpStep.monsterLevel: 'MonsterLevel',
    HelpStep.spellTrapType: 'SpellTrapType',
    HelpStep.cardImage: 'CardImage',
    HelpStep.linkArrows: 'LinkArrows',
    HelpStep.monsterType: 'MonsterType',
    HelpStep.cardDescription: 'CardDescription',
    HelpStep.atk: 'Atk',
    HelpStep.def: 'Def',
    HelpStep.linkRating: 'LinkRating',
    HelpStep.creatorName: 'CreatorName',
  };
  int helpStep = HelpStep.none;

  final cardTypeStreamController = BehaviorSubject<CardType>();
  final defStreamController = BehaviorSubject<String>();
  final atkStreamController = BehaviorSubject<String>();
  final atkDefTextStyleStreamController = BehaviorSubject<TextStyle>();

  void init() {
    cardTypeStreamController.add(currentCard.cardType.nullSafe());
  }

  @override
  void dispose() {
    cardTypeStreamController.close();
    defStreamController.close();
    atkStreamController.close();
    atkDefTextStyleStreamController.close();
    super.dispose();
  }

  void startHelp() {
    helpStep = 1;
    notifyListeners();
  }

  void prevHelpStep() {
    if (helpStep != 1) {
      helpStep--;
    } else {
      helpStep = HelpStep.lastStep;
    }
    final cardType = currentCard.cardType;
    while ((cardType.nullSafe().group == CardTypeGroup.monster &&
        helpStep == HelpStep.spellTrapType) ||
        (cardType.nullSafe().group != CardTypeGroup.monster &&
            [
              HelpStep.cardAttribute,
              HelpStep.monsterLevel,
              HelpStep.linkArrows,
              HelpStep.monsterType,
              HelpStep.atk,
              HelpStep.def,
              HelpStep.linkRating,
            ].contains(helpStep)) ||
        (cardType == CardType.link &&
            [HelpStep.monsterLevel, HelpStep.def].contains(helpStep)) ||
        (cardType != CardType.link &&
            [HelpStep.linkArrows, HelpStep.linkRating].contains(helpStep))) {
      helpStep--;
    }
    notifyListeners();
  }

  void nextHelpStep() {
    if (helpStep != HelpStep.lastStep) {
      helpStep++;
    } else {
      helpStep = 1;
    }
    final cardType = currentCard.cardType;
    while ((cardType.nullSafe().group == CardTypeGroup.monster &&
            helpStep == HelpStep.spellTrapType) ||
        (cardType.nullSafe().group != CardTypeGroup.monster &&
            [
              HelpStep.cardAttribute,
              HelpStep.monsterLevel,
              HelpStep.linkArrows,
              HelpStep.monsterType,
              HelpStep.atk,
              HelpStep.def,
              HelpStep.linkRating,
            ].contains(helpStep)) ||
        (cardType == CardType.link &&
            [HelpStep.monsterLevel, HelpStep.def].contains(helpStep)) ||
        (cardType != CardType.link &&
            [HelpStep.linkArrows, HelpStep.linkRating].contains(helpStep))) {
      helpStep++;
    }
    notifyListeners();
  }

  void endHelp() {
    helpStep = 0;
    notifyListeners();
  }

  setCardType(CardType type) {
    currentCard.cardType = type;
    cardTypeStreamController.add(type);
    while ((type.nullSafe().group == CardTypeGroup.monster &&
        helpStep == HelpStep.spellTrapType) ||
        (type.nullSafe().group != CardTypeGroup.monster &&
            [
              HelpStep.cardAttribute,
              HelpStep.monsterLevel,
              HelpStep.linkArrows,
              HelpStep.monsterType,
              HelpStep.atk,
              HelpStep.def,
              HelpStep.linkRating,
            ].contains(helpStep)) ||
        (type == CardType.link &&
            [HelpStep.monsterLevel, HelpStep.def].contains(helpStep)) ||
        (type != CardType.link &&
            [HelpStep.linkArrows, HelpStep.linkRating].contains(helpStep))) {
      helpStep--;
    }
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

  setCardLevel(int level) {
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
    currentCard.def = def;
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

  setLinkArrowAt(int index) {
    final linkArrows = currentCard.linkArrows.nullSafe();
    final newLinkArrowList = <bool>[];
    for (int i = 0; i < linkArrows.length; i++) {
      if (i == index) {
        newLinkArrowList.add(!linkArrows[i]);
        if (newLinkArrowList[i]) {
          linkRating++;
        } else {
          linkRating--;
        }
      } else {
        newLinkArrowList.add(linkArrows[i]);
      }
    }
    currentCard.linkArrows = newLinkArrowList;
    notifyListeners();
  }

  setLinkRating(String rating) {
    final parseResult = int.tryParse(rating).nullSafe();
    linkRating = parseResult == 9 ? 8 : parseResult;
    final linkArrows = currentCard.linkArrows.nullSafe();
    int diff = linkRating - linkArrows.getRating();
    if (diff == 0) {
      return;
    }
    final newLinkArrowList = <bool>[];
    int i = 0;
    if (diff > 0) {
      for (i; i < 8 && diff > 0; i++) {
        if (!linkArrows[i]) {
          diff--;
        }
        newLinkArrowList.add(true);
      }
    } else {
      diff *= -1;
      for (i; i < 8 && diff > 0; i++) {
        if (linkArrows[i]) {
          diff--;
        }
        newLinkArrowList.add(false);
      }
    }
    for (i; i < 8; i++) {
      newLinkArrowList.add(linkArrows[i]);
    }
    currentCard.linkArrows = newLinkArrowList;
    notifyListeners();
  }
}
