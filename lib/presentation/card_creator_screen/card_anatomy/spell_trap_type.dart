import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:yugioh_card_creator/application/extensions.dart';
import 'package:yugioh_card_creator/data/models/yugioh_card.dart';
import 'package:yugioh_card_creator/presentation/card_creator_screen/positions.dart';

import '../../../application/dependency_injection.dart';
import '../../resources/colors.dart';
import '../../resources/images.dart';
import '../../resources/layout.dart';
import '../../resources/styles.dart';
import '../card_creator_view_model.dart';

class SpellTrapType extends StatelessWidget with GetItMixin {
  SpellTrapType({Key? key}) : super(key: key);

  final _cardCreatorViewModel = getIt<CardCreatorViewModel>();

  final _cardWidth = getIt<CardCreatorViewModel>().cardSize.width;

  @override
  Widget build(BuildContext context) {
    final cardType =
        watchOnly((CardCreatorViewModel vm) => vm.currentCard.cardType)
            .nullSafe();
    final currentEffectType =
        watchOnly((CardCreatorViewModel vm) => vm.currentCard.effectType)
            .nullSafe();
    return Stack(children: [
      if (currentEffectType != EffectType.normal)
        Positioned(
          //Offset from the right side of PopupMenuButton
            right: _cardWidth * CardLayout.effectTypeIconRight,
            child: Image.asset(
              currentEffectType.getAssetPath(),
              height: _cardWidth * CardLayout.effectTypeHeight * CardLayout.effectTypeIconScale,
              fit: BoxFit.fitHeight,
            )),
      PopupMenuButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(
              maxWidth: _cardCreatorViewModel.cardSize.width *
                  ScreenLayout.effectTypePopupMenuWidth),
          color: Theme.of(context).colorScheme.tertiary,
          child: Container(
            height: _cardWidth *
                CardLayout.effectTypeHeight *
                CardLayout.effectTypeIconScale,
            alignment: Alignment.center,
            child: Image.asset(
              currentEffectType == EffectType.normal
                  ? cardType == CardType.spell
                      ? ImagePath.normalSpell
                      : ImagePath.normalTrap
                  : cardType == CardType.spell
                      ? ImagePath.nonNormalSpell
                      : ImagePath.nonNormalTrap,
              height: _cardWidth * CardLayout.effectTypeHeight,
              fit: BoxFit.fitHeight,
            ),
          ),
          onSelected: (effectType) {
            _cardCreatorViewModel.setEffectType(effectType);
          },
          itemBuilder: (ctx) {
            final list =
                cardType == CardType.spell ? spellCardTypes : trapCardTypes;
            return list
                .map((effectType) => PopupMenuItem(
                      value: effectType,
                      height: double.minPositive,
                      padding: EdgeInsets.symmetric(
                          vertical: ScreenLayout.editPopupItemPaddingSmall),
                      child: _effectTypeMenuItem(effectType, cardType, context,
                          decorated: effectType == currentEffectType),
                    ))
                .toList();
          }),
    ]);
  }

  Widget _effectTypeMenuItem(
      EffectType effectType, CardType cardType, BuildContext context,
      {bool decorated = false}) {
    return Container(
      padding: const EdgeInsets.only(left: 8),
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [cardType.getMainColor(alphaHex: 'bf'), Colors.black]),
          boxShadow: [
            if (decorated)
              BoxShadow(
                color: Theme.of(context).primaryColor,
                spreadRadius: ScreenLayout.menuItemSpreadRadius,
                blurRadius: ScreenLayout.menuItemBlurRadius,
              )
          ]),
      width: _cardCreatorViewModel.cardSize.width *
          ScreenLayout.effectTypePopupMenuWidth,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            effectType.getName().toUpperCase(),
            style: kMonsterTypeTextStyle.copyWith(color: Colors.white),
          ),
          Image.asset(
            effectType.getAssetPath(),
            width:
                ScreenLayout.editButtonWidth * ScreenLayout.editPopupItemScale,
            height:
                ScreenLayout.editButtonWidth * ScreenLayout.editPopupItemScale,
            fit: BoxFit.fitHeight,
          )
        ],
      ),
    );
  }
}
