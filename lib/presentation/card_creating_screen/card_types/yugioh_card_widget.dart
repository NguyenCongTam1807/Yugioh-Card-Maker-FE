import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../application/dependency_injection.dart';
import '../../resources/styles.dart';
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
  final _cardWidth = getIt<CardCreatorViewModel>().cardSize.width;
  final _cardHeight = getIt<CardCreatorViewModel>().cardSize.height;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      //Card Image
      Positioned(
        top: CardLayout.cardImageTop * _cardWidth,
        left: CardLayout.cardImageLeft * _cardWidth,
        child: const CardImage(),
      ),
      //Card Frame Theme By Type
      CardType(),
      //Card Name
      Positioned(
        top: CardLayout.cardNameTop * _cardWidth,
        left: CardLayout.cardNameLeft * _cardWidth,
        child: const CardName(),
      ),
      //Card Attribute
      Positioned(
        top: CardLayout.cardAttributeIconTop * _cardWidth,
        left: CardLayout.cardAttributeIconLeft * _cardWidth,
        child: CardAttributeIcon(),
      ),
      //Monster Level
      Positioned(
        top: CardLayout.monsterLevelTop * _cardWidth,
        child: MonsterLevel(),
      ),
      //Monster Type
      Positioned(
          top: _cardWidth * CardLayout.monsterTypeTop,
          left: _cardWidth * CardLayout.monsterTypeLeft,
          child: const MonsterType()),
      //Card description
      Positioned(
          top: _cardWidth * CardLayout.cardDescriptionTop,
          left: _cardWidth * CardLayout.cardNameLeft,
          child: const CardDescription()),
      //Card ATK
      Positioned(
        top: _cardWidth * CardLayout.atkTop,
        left: _cardWidth * CardLayout.atkLeft,
        child: Atk(),
      ),
      //Card DEF
      Positioned(
        top: _cardWidth * CardLayout.atkTop,
        left: _cardWidth * CardLayout.defLeft,
        child: Def(),
      ),
      // //Creator Name
      Positioned(
        top: _cardWidth * CardLayout.creatorNameTop,
        left: _cardWidth * CardLayout.creatorNameLeft,
        child: const CreatorName(),
      )
    ]);
  }
}
