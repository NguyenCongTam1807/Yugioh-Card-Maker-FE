import 'package:yugioh_card_creator/presentation/resources/themes.dart';

import '../../data/models/yugioh_card.dart';
import 'images.dart';

class CardDefaults {
  static const defaultAttribute = CardAttribute.light;
  static const defaultCardType = CardType.normal;
  static const defaultEffectType = EffectType.normal;
  static const defaultCardImage = ImagePath.cardImagePlaceHolder;
  static const defaultCardThemeColor = '#fde68a';
  static const defaultCardLevel = 6;
  static const defaultLinkRating = 0;
  static const defaultLinkArrows = [
    false, false, false, false, false, false, false, false,
  ];
}

class AppDefaults {
  static const defaultAppTheme = AppTheme.ancientEgypt;
}