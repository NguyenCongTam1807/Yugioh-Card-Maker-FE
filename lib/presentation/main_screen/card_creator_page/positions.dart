class CardLayout {
  //Card Image Button
  static const cardImageEditButtonTop = 0.968;
  static const cardImageEditButtonLeft = 0.05;

  //CardAttribute icons in popup menu
  static const attributeScale = 1.3;
  static const attributeIconsPerRow = 3;
  static const attributeIconsPerColumn = 3;

  //Card Atk-Def TextField
  static const atkDefBaseFontSize = 13.5/423.6;
  static const unknownAtkDefBaseFontSize = 11/423.6;

  //Relative positions inside a card, proportional to the card's width
  static const cardImageTop = 0.2685;
  static const cardImageLeft = 0.121;
  static const cardImageSize = 0.759;
  static const linkCardImageClipSize = 0.022;

  static const arrowCornerTop = 0.233;
  static const arrowCornerHorizontalMargin = cardImageLeft - cardImageTop + arrowCornerTop;
  static const arrowCornerBottom = arrowCornerTop+cardImageSize+(cardImageTop - arrowCornerTop)*2;
  static const arrowCornerSize = 0.093;
  static const arrowVerticalCentroidLeft = cardImageLeft + cardImageSize/2;
  static const arrowHorizontalCentroidTop = cardImageTop + cardImageSize/2;
  static const arrowSideHalfBaseLength = 0.113;
  static const arrowSideHeight = 0.052;

  static const cardNameTop = 0.07;
  static const cardNameLeft = 0.074;
  static const cardNameWidth = 0.755;
  static const cardNameHeight = 0.108;

  static const cardAttributeIconTop = 0.069;
  static const cardAttributeIconLeft = 0.835;
  static const cardAttributeIconSize = 0.095;

  static const monsterLevelTop = 0.181;
  static const monsterLevelMargin = 0.106;
  static const levelDragFormulaDivider = 0.06566;
  static const levelStarSize = 0.065;
  static const levelStarLeftMargin = 0.000663;

  static const effectTypeTop = monsterLevelTop + (levelStarSize - effectTypeHeight*effectTypeIconScale)/2;
  static const effectTypeRight = monsterLevelMargin;
  static const effectTypeHeight = 0.042;
  static const effectTypeIconRight = 0.016;
  static const effectTypeIconScale = 1.15;

  static const monsterTypeTop = 1.09;
  static const monsterTypeLeft = 0.078;
  static const monsterTypeWidth = 0.844;
  static const monsterTypeHeight = 0.06;

  static const cardDescriptionTop = 1.13;
  static const cardDescriptionWithoutTypeTop = 1.095;
  static const cardDescriptionMargin = 0.078;
  static const cardDescriptionHeight = 0.2;
  static const cardDescriptionHeightWithoutType = 0.274;

  static const atkTop = 1.325;
  static const atkLeft = 0.625;
  static const atkWidth = 0.1;
  static const atkHeight = 0.048;

  static const defLeft = 0.828;

  static const linkRatingTop = 1.3335;
  static const linkRatingLeft = 0.889;
  static const linkRatingHeight = 0.048;
  static const linkRatingWidth = 0.035;

  static const creatorNameTop = 1.378;
  static const creatorNameLeft = 0.5;
  static const creatorNameWidth = 0.407;
  static const creatorNameHeight = 0.06;
}

class ScreenPos {
  static const cardWidthRatio = 813;
  static const cardHeightRatio = 1185;
  static const cardMarginRatio = 0.26;

  //Card Image Button
  static const cardImageEditButtonTop = 0.943;

  //Card Type Button
  static const cardTypeEditButtonTop = 0.187;

  //Common
  static const cardEditButtonLeft = 0.07;
}

