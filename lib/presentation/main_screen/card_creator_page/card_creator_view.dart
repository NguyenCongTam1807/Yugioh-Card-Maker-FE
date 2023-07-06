import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:yugioh_card_creator/presentation/main_screen/card_creator_page/outer_buttons/save_card_button.dart';
import 'package:yugioh_card_creator/presentation/main_screen/custom_widgets/highlight_wrapper.dart';

import '../../../application/dependency_injection.dart';
import '../../resources/images.dart';
import '../../resources/layout.dart';
import '../../resources/strings.dart';
import '../../resources/styles.dart';
import 'card_widget/yugioh_card_widget.dart';
import 'help_step.dart';
import 'outer_buttons/card_image_button.dart';
import 'outer_buttons/card_type_button.dart';
import 'positions.dart';
import 'card_creator_view_model.dart';

class CardCreatorView extends StatefulWidget with GetItStatefulWidgetMixin {
  CardCreatorView({Key? key}) : super(key: key);

  @override
  State<CardCreatorView> createState() => _CardCreatorViewState();
}

class _CardCreatorViewState extends State<CardCreatorView>
    with GetItStateMixin {
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
    final helpStep = watchOnly((CardCreatorViewModel vm) => vm.helpStep);

    return Center(child: SingleChildScrollView(
      child: LayoutBuilder(builder: (ctx, constraint) {
        final deviceHeight =
            ui.window.physicalSize.longestSide / ui.window.devicePixelRatio;
        final double statusBarHeight =
            ui.window.padding.top / ui.window.devicePixelRatio;
        final screenHeight =
            deviceHeight - AppBar().preferredSize.height - statusBarHeight;

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
                    top: cardTop - ScreenLayout.helperColorPadding,
                    left: iconLeft - ScreenLayout.helperColorPadding,
                    child: HighlightWrapper(
                        highlightPadding: ScreenLayout.helperColorPadding,
                        child: CardTypeButton())),
                Positioned(
                    top: cardTop + cardHeight - ScreenLayout.editButtonHeight - ScreenLayout.helperColorPadding,
                    left: iconLeft - ScreenLayout.helperColorPadding,
                    child: HighlightWrapper(
                        highlightPadding: ScreenLayout.helperColorPadding,
                        child: CardImageButton())),
                Positioned(
                  top: cardTop,
                  left: cardLeft,
                  child: SizedBox(
                      width: cardWidth,
                      height: cardHeight,
                      child: RepaintBoundary(
                          key: _cardCreatorViewModel.cardKey,
                          child: YugiohCardWidget())),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (helpStep != HelpStep.none)
                              ElevatedButton(
                                  onPressed: () {
                                    _cardCreatorViewModel.prevHelpStep();
                                  },
                                  child: const Text(Strings.prev)),
                            const Spacer(),
                            HighlightWrapper(child: SaveCardButton()),
                            const Spacer(),
                            if (helpStep != HelpStep.none)
                              ElevatedButton(
                                  onPressed: () {
                                    _cardCreatorViewModel.nextHelpStep();
                                  },
                                  child: const Text(Strings.next)),
                          ],
                        ),
                      ],
                    ),
                    if (helpStep != HelpStep.none)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Opacity(
                            opacity: 0,
                            child: ElevatedButton(
                                onPressed: null, child: Text(Strings.end)),
                          ),
                          // if (helpStep > HelpStep.linkArrows ||
                          //     helpStep == HelpStep.cardImageButton)
                            _getHelperText(helpStep),
                          ElevatedButton(
                              onPressed: () {
                                _cardCreatorViewModel.endHelp();
                              },
                              child: const Text(Strings.end))
                        ],
                      ),
                  ],
                ),
              ],
            );
          }),
        );
      }),
    ));
  }

  Widget _getHelperText(int helpStep) {
    String name = '';
    String description = '';
    switch (helpStep) {
      case HelpStep.saveCardButton:
        {
          name = Strings.saveCardButtonName;
          description = Strings.saveCardButtonDesc;
        }
        break;
      case HelpStep.cardTypeButton:
        {
          name = Strings.cardTypeButtonName;
          description = Strings.cardTypeButtonDesc;
        }
        break;
      case HelpStep.cardImageButton:
        {
          name = Strings.cardImageButtonName;
          description = Strings.cardImageButtonDesc;
        }
        break;
      case HelpStep.cardName:
        {
          name = Strings.cardNameName;
          description = Strings.cardNameDesc;
        }
        break;
      case HelpStep.cardAttribute:
        {
          name = Strings.cardAttributeName;
          description = Strings.cardAttributeDesc;
        }
        break;
      case HelpStep.monsterLevel:
        {
          name = Strings.monsterLevelName;
          description = Strings.monsterLevelDesc;
        }
        break;
      case HelpStep.cardImage:
        {
          name = Strings.cardImageName;
          description = Strings.cardImageDesc;
        }
        break;
      case HelpStep.spellTrapType:
        {
          name = Strings.spellTrapTypeName;
          description = Strings.spellTrapTypeDesc;
        }
        break;
      case HelpStep.linkArrows:
        {
          name = Strings.linkArrowsName;
          description = Strings.linkArrowsDesc;
        }
        break;
      case HelpStep.monsterType:
        {
          name = Strings.monsterTypeName;
          description = Strings.monsterTypeDesc;
        }
        break;
      case HelpStep.cardDescription:
        {
          name = Strings.cardDescriptionName;
          description = Strings.cardDescriptionDesc;
        }
        break;
      case HelpStep.atk:
        {
          name = Strings.atkName;
          description = Strings.atkDesc;
        }
        break;
      case HelpStep.def:
        {
          name = Strings.defName;
          description = Strings.defDesc;
        }
        break;
      case HelpStep.linkRating:
        {
          name = Strings.linkRatingName;
          description = Strings.linkRatingDesc;
        }
        break;
      case HelpStep.creatorName:
        {
          name = Strings.creatorNameName;
          description = Strings.creatorNameDesc;
        }
        break;
    }
    return Expanded(
      child: Column(
        children: [
          Text(
            name,
            style: kSettingGroupTextStyle,
            textAlign: TextAlign.center,
          ),
          Text(
            description,
            style: kSettingTextStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
