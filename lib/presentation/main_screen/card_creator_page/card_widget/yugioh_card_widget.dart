import 'package:flutter/material.dart';
import 'package:yugioh_card_creator/application/extensions.dart';

import '../../../../application/dependency_injection.dart';
import '../../../../data/models/yugioh_card.dart';
import 'card_elements/atk.dart';
import 'card_elements/card_attribute.dart';
import 'card_elements/card_description.dart';
import 'card_elements/card_frame.dart';
import 'card_elements/card_image.dart';
import 'card_elements/card_name.dart';
import 'card_elements/creator_name.dart';
import 'card_elements/def.dart';
import 'card_elements/link_arrows.dart';
import 'card_elements/link_rating.dart';
import 'card_elements/monster_level.dart';
import 'card_elements/monster_type.dart';
import 'card_elements/spell_trap_type.dart';
import '../positions.dart';
import '../card_creator_view_model.dart';

class YugiohCardWidget extends StatelessWidget {
  YugiohCardWidget({Key? key}) : super(key: key);

  final _cardCreatorViewModel = getIt<CardCreatorViewModel>();
  final _cardWidth = getIt<CardCreatorViewModel>().cardSize.width;

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<CardType>(
        stream: _cardCreatorViewModel.cardTypeStreamController.stream,
        builder: (context, snapshot) {
          final cardTypeGroup = snapshot.data?.group;
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
            if (cardTypeGroup == CardTypeGroup.monster)
              Positioned(
                top: CardLayout.cardAttributeIconTop * _cardWidth,
                left: CardLayout.cardAttributeIconLeft * _cardWidth,
                child: CardAttributeIcon(),
              ),
            //Monster Level
            if (cardTypeGroup == CardTypeGroup.monster &&
                snapshot.data != CardType.link)
              Positioned(
                top: CardLayout.monsterLevelTop * _cardWidth,
                child: MonsterLevel(),
              ),
            if (cardTypeGroup != CardTypeGroup.monster)
              Positioned(
                top: _cardWidth * CardLayout.effectTypeTop,
                right: _cardWidth * CardLayout.effectTypeRight,
                child: SpellTrapType(),
              ),
            //Link arrows
            if (snapshot.data == CardType.link)
              LinkArrows(),
            //Monster Type
            if (cardTypeGroup == CardTypeGroup.monster)
              Positioned(
                  top: _cardWidth * CardLayout.monsterTypeTop,
                  left: _cardWidth * CardLayout.monsterTypeLeft,
                  child: const MonsterType()),
            //Card description
            Positioned(
                top: _cardWidth *
                    (cardTypeGroup == CardTypeGroup.monster
                        ? CardLayout.cardDescriptionTop
                        : CardLayout.cardDescriptionWithoutTypeTop),
                left: _cardWidth * CardLayout.cardDescriptionMargin,
                child: const CardDescription()),
            //Card ATK
            if (cardTypeGroup == CardTypeGroup.monster)
              Positioned(
                top: _cardWidth * CardLayout.atkTop,
                left: _cardWidth * CardLayout.atkLeft,
                child: Atk(),
              ),
            //Card DEF
            if (cardTypeGroup == CardTypeGroup.monster &&
                snapshot.data != CardType.link)
              Positioned(
                top: _cardWidth * CardLayout.atkTop,
                left: _cardWidth * CardLayout.defLeft,
                child: Def(),
              ),
            //Link rating for Link monster cards
            if (snapshot.data == CardType.link)
              Positioned(
                  top: _cardWidth * CardLayout.linkRatingTop,
                  left: _cardWidth * CardLayout.linkRatingLeft,
                  child: LinkRating()),
            //Creator Name
            Positioned(
              top: _cardWidth * CardLayout.creatorNameTop,
              left: _cardWidth * CardLayout.creatorNameLeft,
              child: CreatorName(),
            ),
          ]);
        });
  }
}
