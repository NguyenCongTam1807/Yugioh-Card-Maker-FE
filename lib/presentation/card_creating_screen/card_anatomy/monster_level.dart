import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:yugioh_card_creator/application/extensions.dart';
import 'package:yugioh_card_creator/presentation/card_creating_screen/card_creator_view_model.dart';

import '../../../application/dependency_injection.dart';
import '../../resources/images.dart';
import '../card_constants.dart';

class MonsterLevel extends StatelessWidget with GetItMixin{
  MonsterLevel({Key? key}) : super(key: key);
  final _cardCreatorViewModel = getIt<CardCreatorViewModel>();
  final _cardWidth = getIt<CardCreatorViewModel>().cardSize.width;

  @override
  Widget build(BuildContext context) {
    final cardLevel = watchOnly((CardCreatorViewModel vm) => vm.currentCard.level);

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: _cardWidth * CardConstants.monsterLevelMargin),
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          final x = details.localPosition.dx;
          final level = 12 - x / _cardWidth ~/ CardConstants.levelDragFormulaDivider;
          if (level >= 1 && level <= 12) {
            _cardCreatorViewModel.setCardLevel(
              12 - x / _cardWidth ~/ CardConstants.levelDragFormulaDivider);
          }
        },
        onTapDown: (details) {
          final x = details.localPosition.dx;
          final level = 12 - x / _cardWidth ~/ CardConstants.levelDragFormulaDivider;
          if (level >= 1 && level <= 12) {
            _cardCreatorViewModel.setCardLevel(
              12 - x / _cardWidth ~/ CardConstants.levelDragFormulaDivider);
          }
        },
        behavior: HitTestBehavior.translucent,
        child: SizedBox(
          width: _cardWidth * (1 - 2 * CardConstants.monsterLevelMargin),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(cardLevel.nullSafe(), (index) => LevelStar()),
          ),
        ),
      ),
    );
  }
}

class LevelStar extends StatelessWidget {
  LevelStar({Key? key}) : super(key: key);

  final starSize = getIt<CardCreatorViewModel>().cardSize.width *
      CardConstants.levelStarWidth;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: CardConstants.levelStarLeftMargin),
      width: starSize,
      height: starSize,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImagePath.cardLevelStar), fit: BoxFit.contain)),
    );
  }
}
