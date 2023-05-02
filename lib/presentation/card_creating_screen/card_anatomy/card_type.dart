import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:yugioh_card_creator/application/extensions.dart';

import '../../../application/dependency_injection.dart';
import '../positions.dart';
import '../card_creator_view_model.dart';

class CardType extends StatelessWidget with GetItMixin{
  CardType({Key? key}) : super(key: key);
  final _cardCreatorViewModel = getIt<CardCreatorViewModel>();
  final _cardWidth = getIt<CardCreatorViewModel>().cardSize.width;
  final _cardHeight = getIt<CardCreatorViewModel>().cardSize.height;

  @override
  Widget build(BuildContext context) {
    final cardType = watchOnly((CardCreatorViewModel vm) => vm.currentCard.cardType);

    return ClipPath(
      clipper: RectangleHoleClipper(
          left: CardPos.cardImageLeft * _cardWidth,
          top: CardPos.cardImageTop * _cardWidth,
          insideWidth: CardPos.cardImageSize * _cardWidth,
          insideHeight: CardPos.cardImageSize * _cardWidth,
          outerWidth: _cardWidth,
          outerHeight: _cardHeight),
      child: Image.asset(
        cardType.nullSafe().getAssetPath(),
        fit: BoxFit.cover,
      ),
    );
  }
}

class RectangleHoleClipper extends CustomClipper<Path> {
  final double left;
  final double top;
  final double insideWidth;
  final double insideHeight;
  final double outerWidth;
  final double outerHeight;

  RectangleHoleClipper(
      {required this.left,
      required this.top,
      required this.insideWidth,
      required this.insideHeight,
      required this.outerWidth,
      required this.outerHeight});

  @override
  Path getClip(Size size) {
    final innerRect = Rect.fromLTWH(left, top, insideWidth, insideHeight);
    final outerRect = Rect.fromLTWH(0, 0, outerWidth, outerHeight);
    final path = Path()
      ..fillType = PathFillType.evenOdd
      ..addRect(innerRect)
      ..addRect(outerRect);
    return path;
  }

  @override
  bool shouldReclip(covariant RectangleHoleClipper oldClipper) {
    return false;
  }
}
