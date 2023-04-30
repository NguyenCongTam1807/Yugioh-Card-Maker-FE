import 'package:flutter/material.dart';

import '../../../application/dependency_injection.dart';
import '../positions.dart';
import '../card_creator_view_model.dart';

class CardFrame extends StatelessWidget {
  CardFrame({Key? key}) : super(key: key);
  final _cardCreatorViewModel = getIt<CardCreatorViewModel>();
  final _cardWidth = getIt<CardCreatorViewModel>().cardSize.width;
  final _cardHeight = getIt<CardCreatorViewModel>().cardSize.height;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: RectangleHoleClipper(
          left: CardPos.cardImageLeft * _cardWidth,
          top: CardPos.cardImageTop * _cardWidth,
          insideWidth: CardPos.cardImageSize * _cardWidth,
          insideHeight: CardPos.cardImageSize * _cardWidth,
          outerWidth: _cardWidth,
          outerHeight: _cardHeight),
      child: Container(
        color: Colors.red.withOpacity(0.5),
        child: Image.asset(
          _cardCreatorViewModel.getCardTypeAssetImage(),
          fit: BoxFit.cover,
        ),
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
