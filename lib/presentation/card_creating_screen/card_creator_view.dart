import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:yugioh_card_creator/application/extensions.dart';

import '../../application/dependency_injection.dart';
import '../../data/models/yugioh_card.dart';
import 'card_constants.dart';
import '../resources/routes.dart';
import '../resources/strings.dart';
import 'card_creator_view_model.dart';
import 'card_types/monster_card.dart';
import 'card_types/spell_card.dart';
import 'card_types/trap_card.dart';
import 'edit_buttons/card_image_button.dart';

class CardCreatorView extends StatefulWidget with GetItStatefulWidgetMixin {
  CardCreatorView({Key? key}) : super(key: key);

  @override
  State<CardCreatorView> createState() => _CardCreatorViewState();
}

class _CardCreatorViewState extends State<CardCreatorView>
    with GetItStateMixin {
  final _cardCreatorViewModel = getIt<CardCreatorViewModel>();

  late final double cardWidth;
  late final double cardHeight;

  @override
  void initState() {
    _setCardSize();
    super.initState();
  }

  void _setCardSize() {
    const cardWidthRatio = CardConstants.cardWidthRatio;
    const cardHeightRatio = CardConstants.cardHeightRatio;
    const widthHeightRatio =
        CardConstants.cardWidthRatio / CardConstants.cardHeightRatio;
    const marginRatio = CardConstants.cardMarginRatio;

    final screenWidth =
        (window.physicalSize.shortestSide / window.devicePixelRatio);
    final screenHeight =
        (window.physicalSize.longestSide / window.devicePixelRatio);

    if (screenHeight / cardHeightRatio > screenWidth / cardWidthRatio) {
      cardHeight = screenHeight * (1 - marginRatio);
      cardWidth = cardHeight * widthHeightRatio;
    } else {
      cardWidth = screenWidth * (1 - marginRatio);
      cardHeight = cardWidth / widthHeightRatio;
    }

    _cardCreatorViewModel.cardSize = Size(cardWidth, cardHeight);
  }

  @override
  Widget build(BuildContext context) {
    final cardType =
        watchOnly((CardCreatorViewModel vm) => vm.currentCard.cardType);
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.appName),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RouteNames.settings);
              },
              icon: const Icon(Icons.settings_outlined)),
        ],
      ),
      body: Center(
          child: SingleChildScrollView(
        child: SizedBox(
          width: cardWidth,
          height: cardHeight,
          child: LayoutBuilder(
            builder: (ctx, constraints) {
              final cardWidth = watchOnly((CardCreatorViewModel vm) => vm.cardSize.width);
              return Stack(children: [
                //Card background by card type
                _yugiohCardOfType(cardType.nullSafe()),
                //Card Image Button
                Positioned(
                    top: cardWidth * CardConstants.cardImageEditButtonTop,
                    left: cardWidth * CardConstants.cardImageEditButtonLeft,
                    child: CardImageButton())
              ]);
            },
          ),
        ),
      )),
    );
  }

  Widget _yugiohCardOfType(CardType type) {
    switch (type) {
      case CardType.spell:
        return const SpellCard();
      case CardType.trap:
        return const TrapCard();
      default:
        return const MonsterCard();
    }
  }
}
