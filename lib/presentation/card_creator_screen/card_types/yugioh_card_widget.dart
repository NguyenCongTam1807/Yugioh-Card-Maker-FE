import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:yugioh_card_creator/application/extensions.dart';
import 'package:yugioh_card_creator/presentation/card_creator_screen/card_anatomy/spell_trap_type.dart';

import '../../../application/dependency_injection.dart';
import '../../../data/models/yugioh_card.dart';
import '../../resources/styles.dart';
import '../card_anatomy/atk.dart';
import '../card_anatomy/card_attribute.dart';
import '../card_anatomy/card_description.dart';
import '../card_anatomy/card_frame.dart';
import '../card_anatomy/card_image.dart';
import '../card_anatomy/card_name.dart';
import '../card_anatomy/creator_name.dart';
import '../card_anatomy/def.dart';
import '../card_anatomy/monster_level.dart';
import '../card_anatomy/monster_type.dart';
import '../positions.dart';
import '../card_creator_view_model.dart';

class YugiohCardWidget extends StatelessWidget {
  YugiohCardWidget({Key? key}) : super(key: key);

  final _cardCreatorViewModel = getIt<CardCreatorViewModel>();

  final _cardWidth = getIt<CardCreatorViewModel>().cardSize.width;

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<CardTypeGroup>(
      stream: _cardCreatorViewModel.cardTypeGroupStreamController.stream,
      builder: (context, snapshot) {
        return Stack(children: [
          //Card Image
          Positioned(
            top: CardLayout.cardImageTop * _cardWidth,
            left: CardLayout.cardImageLeft * _cardWidth,
            child: const CardImage(),
          ),
          //Card Frame Theme By Type
          CardFrame(),
          //Card Name
          Positioned(
            top: CardLayout.cardNameTop * _cardWidth,
            left: CardLayout.cardNameLeft * _cardWidth,
            child: CardName(),
          ),
          //Card Attribute
          if (snapshot.data == CardTypeGroup.monster)
            Positioned(
              top: CardLayout.cardAttributeIconTop * _cardWidth,
              left: CardLayout.cardAttributeIconLeft * _cardWidth,
              child: CardAttributeIcon(),
            ),
          //Monster Level
          if (snapshot.data == CardTypeGroup.monster)
            Positioned(
              top: CardLayout.monsterLevelTop * _cardWidth,
              child: MonsterLevel(),
            ),
          if (snapshot.data != CardTypeGroup.monster)
            Positioned(
              top: _cardWidth*CardLayout.effectTypeTop,
              right: _cardWidth*CardLayout.effectTypeRight,
              child: SpellTrapType(),
            ),
          //Monster Type
          if (snapshot.data == CardTypeGroup.monster)
            Positioned(
                top: _cardWidth * CardLayout.monsterTypeTop,
                left: _cardWidth * CardLayout.monsterTypeLeft,
                child: const MonsterType()),
          //Card description
          Positioned(
              top: _cardWidth * (snapshot.data == CardTypeGroup.monster?CardLayout.cardDescriptionTop: CardLayout.cardDescriptionWithoutTypeTop),
              left: _cardWidth * CardLayout.cardDescriptionMargin,
              child: const CardDescription()),
          //Card ATK
          if (snapshot.data == CardTypeGroup.monster)
            Positioned(
              top: _cardWidth * CardLayout.atkTop,
              left: _cardWidth * CardLayout.atkLeft,
              child: Atk(),
            ),
          //Card DEF
          if (snapshot.data == CardTypeGroup.monster)
            Positioned(
              top: _cardWidth * CardLayout.atkTop,
              left: _cardWidth * CardLayout.defLeft,
              child: Def(),
            ),
          // //Creator Name
          Positioned(
            top: _cardWidth * CardLayout.creatorNameTop,
            left: _cardWidth * CardLayout.creatorNameLeft,
            child: CreatorName(),
          )
        ]);
      }
    );
  }
}
