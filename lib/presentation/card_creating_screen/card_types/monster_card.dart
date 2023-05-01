import 'package:flutter/material.dart';

import '../../../application/dependency_injection.dart';
import '../card_anatomy/atk.dart';
import '../card_anatomy/card_attribute.dart';
import '../card_anatomy/card_description.dart';
import '../card_anatomy/card_type.dart';
import '../card_anatomy/card_image.dart';
import '../card_anatomy/card_name.dart';
import '../card_anatomy/creator_name.dart';
import '../card_anatomy/def.dart';
import '../card_anatomy/monster_level.dart';
import '../card_anatomy/monster_type.dart';
import '../positions.dart';
import '../card_creator_view_model.dart';

class MonsterCard extends StatefulWidget {
  const MonsterCard({Key? key}) : super(key: key);

  @override
  State<MonsterCard> createState() => _MonsterCardState();
}

class _MonsterCardState extends State<MonsterCard> {

  final cardWidth = getIt<CardCreatorViewModel>().cardSize.width;

  @override
  Widget build(BuildContext context) {

    return Stack(children: [
      //Card Image
      Positioned(
        top: CardPos.cardImageTop * cardWidth,
        left: CardPos.cardImageLeft * cardWidth,
        child: CardImage(),
      ),
      //Card Frame Theme By Type
      CardType(),
      // Container(
      //   color: Colors.red.withOpacity(0.5),
      //   child: Image.asset(_cardCreatorViewModel.getCardTypeAssetImage(), fit: BoxFit.cover,) ,
      // ),
      //Card Name
      Positioned(
        top: CardPos.cardNameTop * cardWidth,
        left: CardPos.cardNameLeft * cardWidth,
        child:
        const CardName(),
      ),
      //Card Attribute
      Positioned(
        top: CardPos.cardAttributeIconTop * cardWidth,
        left: CardPos.cardAttributeIconLeft * cardWidth,
        child: CardAttributeIcon(),
      ),
      //Monster Level
      Positioned(
        top: CardPos.monsterLevelTop * cardWidth,
        child: MonsterLevel(),
      ),
      //Monster Type
      Positioned(
          top: cardWidth * CardPos.monsterTypeTop,
          left: cardWidth * CardPos.monsterTypeLeft,
          child: const MonsterType()),
      //Card description
      Positioned(
          top: cardWidth * CardPos.cardDescriptionTop,
          left: cardWidth * CardPos.cardNameLeft,
          child: const CardDescription()),
      //Card ATK
      Positioned(
        top: cardWidth * CardPos.atkTop,
        left: cardWidth * CardPos.atkLeft,
        child: const Atk(),
      ),
      //Card DEF
      Positioned(
        top: cardWidth * CardPos.atkTop,
        left: cardWidth * CardPos.defLeft,
        child: const Def(),
      ),
      //Creator Name
      Positioned(
        top: cardWidth * CardPos.creatorNameTop,
        left: cardWidth * CardPos.creatorNameLeft,
        child: const CreatorName(),
      )
    ]);
  }
}
