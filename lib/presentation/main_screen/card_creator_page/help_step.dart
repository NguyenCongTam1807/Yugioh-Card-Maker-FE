class HelpStep {
  static const none = 0;
  static const cardMakerMenuButton = 1;
  static const cardTypeButton = 2;
  static const cardImageButton = 3;
  static const cardName = 4;
  static const cardAttribute = 5;
  static const monsterLevel = 6; //monster cards except link
  static const spellTrapType = 7; // spell/trap cards
  static const cardImage = 8;
  static const linkArrows = 9; // link monster card
  static const monsterType = 10; // monster cards
  static const cardDescription = 11;
  static const atk = 12; // monster cards
  static const def = 13; // monster cards except link
  static const linkRating = 14; //link monster card
  static const creatorName = 15;
  static const lastStep = 15;

  static const helpItemNameMap = {
    HelpStep.cardMakerMenuButton: 'CardMakerMenuButton',
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
}

