import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:yugioh_card_creator/application/extensions.dart';

import '../../../../../application/dependency_injection.dart';
import '../../../../../data/models/yugioh_card.dart';
import '../../positions.dart';
import '../../card_creator_view_model.dart';

class CardFrame extends StatelessWidget with GetItMixin {
  CardFrame({Key? key}) : super(key: key);
  final _cardWidth = getIt<CardCreatorViewModel>().cardSize.width;
  final _cardHeight = getIt<CardCreatorViewModel>().cardSize.height;

  @override
  Widget build(BuildContext context) {
    final cardType =
        watchOnly((CardCreatorViewModel vm) => vm.currentCard.cardType);

    return ClipPath(
      clipper: cardType == CardType.link
          ? OctagonHoleClipper(
              left: CardLayout.cardImageLeft * _cardWidth,
              top: CardLayout.cardImageTop * _cardWidth,
              innerWidth: CardLayout.cardImageSize * _cardWidth,
              innerHeight: CardLayout.cardImageSize * _cardWidth,
              outerWidth: _cardWidth,
              outerHeight: _cardHeight,
              clipSize: CardLayout.linkCardImageClipSize * _cardWidth)
          : RectangleHoleClipper(
              left: CardLayout.cardImageLeft * _cardWidth,
              top: CardLayout.cardImageTop * _cardWidth,
              innerWidth: CardLayout.cardImageSize * _cardWidth,
              innerHeight: CardLayout.cardImageSize * _cardWidth,
              outerWidth: _cardWidth,
              outerHeight: _cardHeight),
      child: Image.asset(
        cardType.nullSafe().getAssetPath(),
        fit: BoxFit.cover,
        filterQuality: FilterQuality.medium,
      ),
    );
  }
}

class RectangleHoleClipper extends CustomClipper<Path> {
  final double left;
  final double top;
  final double innerWidth;
  final double innerHeight;
  final double outerWidth;
  final double outerHeight;

  RectangleHoleClipper({
    required this.left,
    required this.top,
    required this.innerWidth,
    required this.innerHeight,
    required this.outerWidth,
    required this.outerHeight,
  });

  @override
  Path getClip(Size size) {
    final innerRect = Rect.fromLTWH(left, top, innerWidth, innerHeight);
    final outerRect = Rect.fromLTWH(0, 0, outerWidth, outerHeight);
    final Path path = Path()
      ..fillType = PathFillType.evenOdd
      ..addRect(innerRect)
      ..addRect(outerRect)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant RectangleHoleClipper oldClipper) {
    return false;
  }
}

class OctagonHoleClipper extends CustomClipper<Path> {
  final double left;
  final double top;
  final double innerWidth;
  final double innerHeight;
  final double outerWidth;
  final double outerHeight;
  final double clipSize;
  OctagonHoleClipper(
      {required this.left,
      required this.top,
      required this.innerWidth,
      required this.innerHeight,
      required this.outerWidth,
      required this.outerHeight,
      required this.clipSize});

  @override
  Path getClip(Size size) {
    final outerRect = Rect.fromLTWH(0, 0, outerWidth, outerHeight);
    final path = Path()
      ..fillType = PathFillType.evenOdd
      ..addRect(outerRect)
      ..addPolygon([
        Offset(clipSize + left, top),
        Offset(innerWidth - clipSize + left, top),
        Offset(innerWidth + left, top + clipSize),
        Offset(innerWidth + left, innerHeight - clipSize + top),
        Offset(innerWidth - clipSize + left, innerHeight + top),
        Offset(clipSize + left, innerHeight + top),
        Offset(left, innerHeight - clipSize + top),
        Offset(left, clipSize + top),
      ], true)
    ;

    return path;
  }

  @override
  bool shouldReclip(covariant OctagonHoleClipper oldClipper) {
    return false;
  }
}

class PolygonClipper extends CustomClipper<Path> {
  final List<Offset> vertices;
  final Offset? offset;
  PolygonClipper({
    required this.vertices,
    this.offset,
  });

  @override
  Path getClip(Size size) {
    final path = Path()
      ..fillType = PathFillType.evenOdd
      ..addPolygon(vertices, true);
    if (offset != null) {
      return path.shift(offset!);
    }

    return path;
  }

  @override
  bool shouldReclip(covariant PolygonClipper oldClipper) {
    return false;
  }
}
