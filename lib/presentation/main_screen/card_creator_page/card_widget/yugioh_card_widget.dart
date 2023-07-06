import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:yugioh_card_creator/application/extensions.dart';
import 'package:yugioh_card_creator/presentation/main_screen/custom_widgets/highlight_wrapper.dart';

import '../../../../application/dependency_injection.dart';
import '../../../../data/models/yugioh_card.dart';
import '../../../resources/colors.dart';
import '../../../resources/layout.dart';
import '../help_step.dart';
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

class YugiohCardWidget extends StatelessWidget with GetItMixin {
  YugiohCardWidget({Key? key}) : super(key: key);

  final _cardCreatorViewModel = getIt<CardCreatorViewModel>();
  final _cardWidth = getIt<CardCreatorViewModel>().cardSize.width;

  @override
  Widget build(BuildContext context) {
    final helpStep = watchOnly((CardCreatorViewModel vm) => vm.helpStep);

    return StreamBuilder<CardType>(
        stream: _cardCreatorViewModel.cardTypeStreamController.stream,
        builder: (context, snapshot) {
          final cardTypeGroup = snapshot.data?.group;
          return Stack(children: [
            //Card Image
            Positioned(
              top: CardLayout.cardImageTop * _cardWidth,
              left: CardLayout.cardImageLeft * _cardWidth,
              child: helpStep == HelpStep.cardImage
                  ? Container(
                      decoration: BoxDecoration(
                          color: AppColor.helpOverlayColor,
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.helpOverlayColor,
                              blurRadius: ScreenLayout.editButtonBlurRadius,
                              spreadRadius: ScreenLayout.editButtonSpreadRadius,
                            )
                          ]),
                      child: const CardImage())
                  : const CardImage(),
            ),
            //Card Frame Theme By Type
            CardFrame(),
            //Card Name
            Positioned(
              top: CardLayout.cardNameTop * _cardWidth,
              left: CardLayout.cardNameLeft * _cardWidth,
              child: helpStep == HelpStep.cardName
                  ? Container(
                      decoration: BoxDecoration(
                          color: AppColor.helpOverlayColor,
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.helpOverlayColor,
                              blurRadius: ScreenLayout.editButtonBlurRadius,
                              spreadRadius: ScreenLayout.editButtonSpreadRadius,
                            )
                          ]),
                      child: CardName())
                  : CardName(),
            ),
            //Card Attribute
            if (cardTypeGroup == CardTypeGroup.monster)
              Positioned(
                top: CardLayout.cardAttributeIconTop * _cardWidth -
                    ScreenLayout.helperColorPadding,
                left: CardLayout.cardAttributeIconLeft * _cardWidth -
                    ScreenLayout.helperColorPadding,
                child: HighlightWrapper(
                    highlightPadding: ScreenLayout.helperColorPadding,
                    child: CardAttributeIcon()),
              ),
            //Monster Level
            if (cardTypeGroup == CardTypeGroup.monster &&
                snapshot.data != CardType.link)
              Positioned(
                top: CardLayout.monsterLevelTop * _cardWidth,
                child: HighlightWrapper(child: MonsterLevel()),
              ),
            if (cardTypeGroup != CardTypeGroup.monster)
              Positioned(
                top: _cardWidth * CardLayout.effectTypeTop,
                right: _cardWidth * CardLayout.effectTypeRight,
                child: HighlightWrapper(child: SpellTrapType()),
              ),
            //Link arrows
            if (snapshot.data == CardType.link) LinkArrows(),
            //Monster Type
            if (cardTypeGroup == CardTypeGroup.monster)
              Positioned(
                  top: _cardWidth * CardLayout.monsterTypeTop,
                  left: _cardWidth * CardLayout.monsterTypeLeft,
                  child: HighlightWrapper(child: const MonsterType())),
            //Card description
            Positioned(
                top: _cardWidth *
                    (cardTypeGroup == CardTypeGroup.monster
                        ? CardLayout.cardDescriptionTop
                        : CardLayout.cardDescriptionWithoutTypeTop),
                left: _cardWidth * CardLayout.cardDescriptionMargin,
                child: HighlightWrapper(child: const CardDescription())),
            //Card ATK
            if (cardTypeGroup == CardTypeGroup.monster)
              Positioned(
                top: _cardWidth * CardLayout.atkTop,
                left: _cardWidth * CardLayout.atkLeft,
                child: HighlightWrapper(child: Atk()),
              ),
            //Card DEF
            if (cardTypeGroup == CardTypeGroup.monster &&
                snapshot.data != CardType.link)
              Positioned(
                top: _cardWidth * CardLayout.atkTop,
                left: _cardWidth * CardLayout.defLeft,
                child: HighlightWrapper(child: Def()),
              ),
            //Link rating for Link monster cards
            if (snapshot.data == CardType.link)
              Positioned(
                  top: _cardWidth * CardLayout.linkRatingTop,
                  left: _cardWidth * CardLayout.linkRatingLeft,
                  child: HighlightWrapper(child: LinkRating())),
            //Creator Name
            Positioned(
              top: _cardWidth * CardLayout.creatorNameTop,
              left: _cardWidth * CardLayout.creatorNameLeft,
              child: HighlightWrapper(child: CreatorName()),
            ),
          ]);
        });
  }
}
