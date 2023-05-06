import 'dart:ui';

import 'package:flutter/material.dart';

import '../../application/dependency_injection.dart';
import '../resources/images.dart';
import '../resources/layout.dart';
import '../resources/styles.dart';
import 'card_types/yugioh_card_widget.dart';
import 'edit_buttons/card_type_button.dart';
import 'positions.dart';
import '../resources/routes.dart';
import '../resources/strings.dart';
import 'card_creator_view_model.dart';
import 'edit_buttons/card_image_button.dart';

class CardCreatorView extends StatefulWidget {
  const CardCreatorView({Key? key}) : super(key: key);

  @override
  State<CardCreatorView> createState() => _CardCreatorViewState();
}

class _CardCreatorViewState extends State<CardCreatorView> {
  final _cardCreatorViewModel = getIt<CardCreatorViewModel>();

  @override
  void initState() {
    _cardCreatorViewModel.init();
    super.initState();
  }

  @override
  void dispose() {
    _cardCreatorViewModel.dispose();
    super.dispose();
  }

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
    } else {
      cardHeight = screenHeight * (1 - marginRatio);
      cardWidth = cardHeight * widthHeightRatio;
    }
    kAtkDefTextStyle = kAtkDefTextStyle.copyWith(
        fontSize: CardLayout.atkDefBaseFontSize * cardHeight);
    kUnknownAtkDefTextStyle = kUnknownAtkDefTextStyle.copyWith(
        fontSize: CardLayout.unknownAtkDefBaseFontSize * cardHeight);

    _cardCreatorViewModel.cardSize = Size(cardWidth, cardHeight);
    _cardCreatorViewModel.cardOffset =
        Offset((screenWidth - cardWidth) / 2, (screenHeight - cardHeight) / 2);
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Transform.scale(
          scaleX: 0.9,
          alignment: Alignment.centerLeft,
          child: const Text(Strings.appName)),
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
          final double statusBarHeight =
              window.padding.top / window.devicePixelRatio;
          final screenHeight =
              deviceHeight - appBar.preferredSize.height - statusBarHeight;

          final screenWidth = constraint.maxWidth;

          if (screenWidth >= screenHeight) {
            return Center(
                child: Image.asset(
              ImagePath.cardImagePlaceHolder,
              fit: BoxFit.scaleDown,
            ));
          }
          _setCardLayout(screenWidth, screenHeight);
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.primary,
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
            width: screenWidth,
            height: screenHeight,
            child: LayoutBuilder(builder: (context, constraint) {
              final cardWidth = _cardCreatorViewModel.cardSize.width;
              final cardHeight = _cardCreatorViewModel.cardSize.height;
              final cardLeft = _cardCreatorViewModel.cardOffset.dx;
              final cardTop = _cardCreatorViewModel.cardOffset.dy;
              final iconLeft =
                  (screenWidth - cardWidth - ScreenLayout.editButtonWidth * 2) /
                      4;

              return Stack(
                children: [
                  Positioned(
                      top: cardTop, left: iconLeft, child: CardTypeButton()),
                  Positioned(
                      top: cardTop + cardHeight - ScreenLayout.editButtonHeight,
                      left: iconLeft,
                      child: CardImageButton()),
                  Positioned(
                    top: cardTop,
                    left: cardLeft,
                    child: SizedBox(
                        width: cardWidth,
                        height: cardHeight,
                        child: YugiohCardWidget()),
                  ),
                ],
              );
            }),
          );
        }),
      )),
    );
  }
}
