import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:yugioh_card_creator/application/extensions.dart';

import '../../application/dependency_injection.dart';
import '../../data/models/yugioh_card.dart';
import 'edit_buttons/card_type_button.dart';
import 'positions.dart';
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

  final screenWidth =
      window.physicalSize.shortestSide / window.devicePixelRatio;
  final screenHeight =
      window.physicalSize.longestSide / window.devicePixelRatio;

  @override
  void initState() {
    _setCardSize();
    super.initState();
  }

  void _setCardSize() {
    const cardWidthRatio = ScreenPos.cardWidthRatio;
    const cardHeightRatio = ScreenPos.cardHeightRatio;
    const widthHeightRatio =
        ScreenPos.cardWidthRatio / ScreenPos.cardHeightRatio;
    const marginRatio = ScreenPos.cardMarginRatio;

    late final double cardHeight;
    late final double cardWidth;

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
    final cardSize = _cardCreatorViewModel.cardSize;
    final cardWidth = cardSize.width;
    final cardHeight = cardSize.height;
    final appBar = AppBar(
      title: const Text(Strings.appName),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RouteNames.settings);
            },
            icon: const Icon(Icons.settings)),
      ],
    );
    final appBarHeight =
        appBar.preferredSize.height + MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: Center(
          child: SingleChildScrollView(
        child: SizedBox(
          width: screenWidth,
          height: screenHeight - appBarHeight,
          child: Stack(
            children: [
              Positioned(
                  top: screenWidth *
                      ScreenPos.cardTypeEditButtonTop,
                  left: screenWidth *
                      ScreenPos.cardEditButtonLeft,
                  child: CardTypeButton()),
              Positioned(
                  top: screenWidth *
                      ScreenPos.cardImageEditButtonTop,
                  left: screenWidth *
                      ScreenPos.cardEditButtonLeft,
                  child: CardImageButton()),
              Positioned(
                top: (screenHeight - cardHeight - appBarHeight) / 2,
                left: (screenWidth - cardWidth) / 2,
                child: SizedBox(
                  width: cardWidth,
                  height: cardHeight,
                  child: LayoutBuilder(
                    builder: (ctx, constraints) {
                      final cardType = watchOnly((CardCreatorViewModel vm) =>
                          vm.currentCard.cardType);
                      return Stack(children: [
                        //Card background by card type
                        _yugiohCardOfType(cardType.nullSafe()),
                        //Card Image Button
                        // Positioned(
                        //     top: cardWidth *
                        //         CardConstants.cardImageEditButtonTop,
                        //     left: cardWidth *
                        //         CardConstants.cardImageEditButtonLeft,
                        //     child: CardImageButton())
                      ]);
                    },
                  ),
                ),
              ),
            ],
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
