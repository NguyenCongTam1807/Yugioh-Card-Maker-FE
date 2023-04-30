import 'package:flutter/material.dart';

import '../../../application/dependency_injection.dart';
import '../card_anatomy/atk.dart';
import '../card_anatomy/card_attribute.dart';
import '../card_anatomy/card_description.dart';
import '../card_anatomy/card_image.dart';
import '../card_anatomy/card_name.dart';
import '../card_anatomy/creator_name.dart';
import '../card_anatomy/def.dart';
import '../card_anatomy/monster_level.dart';
import '../card_anatomy/monster_type.dart';
import '../card_constants.dart';
import '../card_creator_view_model.dart';

class MonsterCard extends StatefulWidget {
  const MonsterCard({Key? key}) : super(key: key);

  @override
  State<MonsterCard> createState() => _MonsterCardState();
}

class _MonsterCardState extends State<MonsterCard> {

  final _cardCreatorViewModel = getIt<CardCreatorViewModel>();
  final cardWidth = getIt<CardCreatorViewModel>().cardSize.width;

  @override
  Widget build(BuildContext context) {

    return Stack(children: [
      //Card Image
      Positioned(
        top: CardConstants.cardImageTop * cardWidth,
        left: CardConstants.cardImageLeft * cardWidth,
        child: CardImage(),
      ),
      //Card Frame Theme By Type
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(_cardCreatorViewModel.getCardTypeAssetImage()),
                fit: BoxFit.cover)),
      ),
      //Card Name
      Positioned(
        top: CardConstants.cardNameTop * cardWidth,
        left: CardConstants.cardNameLeft * cardWidth,
        child:
        const CardName(),
      ),
      //Card Attribute
      Positioned(
        top: CardConstants.cardAttributeIconTop * cardWidth,
        left: CardConstants.cardAttributeIconLeft * cardWidth,
        child: CardAttributeIcon(),
      ),
      //Monster Level
      Positioned(
        top: CardConstants.monsterLevelTop * cardWidth,
        child: MonsterLevel(),
      ),
      //Monster Type
      Positioned(
          top: cardWidth * CardConstants.monsterTypeTop,
          left: cardWidth * CardConstants.monsterTypeLeft,
          child: const MonsterType()),
      //Card description
      Positioned(
          top: cardWidth * CardConstants.cardDescriptionTop,
          left: cardWidth * CardConstants.cardNameLeft,
          child: const CardDescription()),
      //Card ATK
      Positioned(
        top: cardWidth * CardConstants.atkTop,
        left: cardWidth * CardConstants.atkLeft,
        child: const Atk(),
      ),
      //Card DEF
      Positioned(
        top: cardWidth * CardConstants.atkTop,
        left: cardWidth * CardConstants.defLeft,
        child: const Def(),
      ),
      //Creator Name
      Positioned(
        top: cardWidth * CardConstants.creatorNameTop,
        left: cardWidth * CardConstants.creatorNameLeft,
        child: const CreatorName(),
      )
    ]);
  }
}
