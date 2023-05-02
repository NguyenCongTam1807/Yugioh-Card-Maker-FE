import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:yugioh_card_creator/application/extensions.dart';

import '../../application/dependency_injection.dart';
import '../../data/models/yugioh_card.dart';
import '../resources/images.dart';
import '../resources/layout.dart';
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

  void _setCardLayout(double screenWidth, double screenHeight) {
    const cardWidthRatio = ScreenPos.cardWidthRatio;
    const cardHeightRatio = ScreenPos.cardHeightRatio;
    const widthHeightRatio =
        ScreenPos.cardWidthRatio / ScreenPos.cardHeightRatio;
    const marginRatio = ScreenPos.cardMarginRatio;

    late final double cardHeight;
    late final double cardWidth;

    if (screenHeight / cardHeightRatio > screenWidth / cardWidthRatio) {
      cardWidth = screenWidth * (1 - marginRatio);
      cardHeight = cardWidth / widthHeightRatio;
      //_cardCreatorViewModel.standardSize = cardWidth;
    } else {
      cardHeight = screenHeight * (1 - marginRatio);
      cardWidth = cardHeight * widthHeightRatio;
      //_cardCreatorViewModel.standardSize = cardHeight;
    }

    _cardCreatorViewModel.cardSize = Size(cardWidth, cardHeight);
    _cardCreatorViewModel.cardOffset =
        Offset((screenWidth - cardWidth) / 2, (screenHeight - cardHeight) / 2);
  }

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: appBar,
      body: Center(child: SingleChildScrollView(
        child: LayoutBuilder(builder: (ctx, constraint) {
          final deviceHeight =
              window.physicalSize.longestSide / window.devicePixelRatio;

          final screenHeight = deviceHeight -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top;
          final screenWidth = constraint.maxWidth;

          if (screenWidth >= screenHeight) {
            return Center(
                child: Image.asset(
              ImagePath.cardImagePlaceHolder,
              fit: BoxFit.scaleDown,
            ));
          }
          _setCardLayout(screenWidth, screenHeight);
          return SizedBox(
            width: screenWidth,
            height: screenHeight,
            child: LayoutBuilder(builder: (context, constraint) {
              final cardWidth = _cardCreatorViewModel.cardSize.width;
              final cardHeight = _cardCreatorViewModel.cardSize.height;
              final cardLeft = _cardCreatorViewModel.cardOffset.dx;
              final cardTop = _cardCreatorViewModel.cardOffset.dy;
              final iconLeft =
                  (screenWidth - cardWidth - Layouts.editButtonWidth * 2) / 4;

              return Stack(
                children: [
                  Positioned(
                      top: cardTop, left: iconLeft, child: CardTypeButton()),
                  Positioned(
                      top: cardTop + cardHeight - Layouts.editButtonHeight,
                      left: iconLeft,
                      child: CardImageButton()),
                  Positioned(
                    top: cardTop,
                    left: cardLeft,
                    child: SizedBox(
                      width: cardWidth,
                      height: cardHeight,
                      child: Builder(
                        builder: (ctx) {
                          final cardType = watchOnly(
                              (CardCreatorViewModel vm) =>
                                  vm.currentCard.cardType);
                          return Stack(children: [
                            //Card frame by card type
                            _yugiohCardOfType(cardType.nullSafe()),
                          ]);
                        },
                      ),
                    ),
                  ),
                ],
              );
            }),
          );
        }),
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
