import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:yugioh_card_creator/application/extensions.dart';

import '../../../../../application/dependency_injection.dart';
import '../../../../../data/models/yugioh_card.dart';
import '../../../../resources/colors.dart';
import '../../../../resources/images.dart';
import '../../../../resources/layout.dart';
import '../../card_creator_view_model.dart';
import '../../help_step.dart';
import '../../positions.dart';
import 'card_frame.dart';

class LinkArrows extends StatelessWidget with GetItMixin {
  LinkArrows({Key? key}) : super(key: key);

  final _cardCreatorViewModel = getIt<CardCreatorViewModel>();
  final _cardWidth = getIt<CardCreatorViewModel>().cardSize.width;
  final _cardHeight = getIt<CardCreatorViewModel>().cardSize.height;

  @override
  Widget build(BuildContext context) {
    final linkArrows = [
      LinkArrow(
        index: 0,
        imagePath: ImagePath.linkArrowTopLeft,
        vertices: [
          const Offset(0, 0),
          Offset(_cardWidth * CardLayout.arrowCornerSize, 0),
          Offset(0, _cardWidth * CardLayout.arrowCornerSize),
        ],
        offset: Offset(_cardWidth * CardLayout.arrowCornerHorizontalMargin,
            _cardWidth * CardLayout.arrowCornerTop),
      ),
      LinkArrow(
        index: 1,
        imagePath: ImagePath.linkArrowTop,
        vertices: [
          Offset(_cardWidth * CardLayout.arrowSideHalfBaseLength * -1, 0),
          Offset(0, _cardWidth * CardLayout.arrowSideHeight * -1),
          Offset(_cardWidth * CardLayout.arrowSideHalfBaseLength, 0),
        ],
        offset: Offset(_cardWidth * CardLayout.arrowVerticalCentroidLeft,
            _cardWidth * CardLayout.cardImageTop),
      ),
      LinkArrow(
        index: 2,
        imagePath: ImagePath.linkArrowTopRight,
        vertices: [
          const Offset(0, 0),
          Offset(_cardWidth * CardLayout.arrowCornerSize * -1, 0),
          Offset(0, _cardWidth * CardLayout.arrowCornerSize),
        ],
        offset: Offset(
            _cardWidth * (1 - CardLayout.arrowCornerHorizontalMargin),
            _cardWidth * CardLayout.arrowCornerTop),
      ),
      LinkArrow(
        index: 3,
        imagePath: ImagePath.linkArrowLeft,
        vertices: [
          Offset(_cardWidth * CardLayout.arrowSideHeight * -1, 0),
          Offset(0, _cardWidth * CardLayout.arrowSideHalfBaseLength),
          Offset(0, _cardWidth * CardLayout.arrowSideHalfBaseLength * -1),
        ],
        offset: Offset(_cardWidth * CardLayout.cardImageLeft,
            _cardWidth * CardLayout.arrowHorizontalCentroidTop),
      ),
      LinkArrow(
        index: 4,
        imagePath: ImagePath.linkArrowRight,
        vertices: [
          Offset(_cardWidth * CardLayout.arrowSideHeight, 0),
          Offset(0, _cardWidth * CardLayout.arrowSideHalfBaseLength),
          Offset(0, _cardWidth * CardLayout.arrowSideHalfBaseLength * -1),
        ],
        offset: Offset(_cardWidth * (1 - CardLayout.cardImageLeft),
            _cardWidth * CardLayout.arrowHorizontalCentroidTop),
      ),
      LinkArrow(
        index: 5,
        imagePath: ImagePath.linkArrowBottomLeft,
        vertices: [
          const Offset(0, 0),
          Offset(_cardWidth * CardLayout.arrowCornerSize, 0),
          Offset(0, _cardWidth * CardLayout.arrowCornerSize * -1),
        ],
        offset: Offset(_cardWidth * CardLayout.arrowCornerHorizontalMargin,
            _cardWidth * (CardLayout.arrowCornerBottom)),
      ),
      LinkArrow(
        index: 6,
        imagePath: ImagePath.linkArrowBottom,
        vertices: [
          Offset(_cardWidth * CardLayout.arrowSideHalfBaseLength * -1, 0),
          Offset(0, _cardWidth * CardLayout.arrowSideHeight),
          Offset(_cardWidth * CardLayout.arrowSideHalfBaseLength, 0),
        ],
        offset: Offset(_cardWidth * CardLayout.arrowVerticalCentroidLeft,
            _cardWidth * (CardLayout.cardImageTop + CardLayout.cardImageSize)),
      ),
      LinkArrow(
        index: 7,
        imagePath: ImagePath.linkArrowBottomRight,
        vertices: [
          const Offset(0, 0),
          Offset(_cardWidth * CardLayout.arrowCornerSize * -1, 0),
          Offset(0, _cardWidth * CardLayout.arrowCornerSize * -1),
        ],
        offset: Offset(
            _cardWidth * (1 - CardLayout.arrowCornerHorizontalMargin),
            _cardWidth * CardLayout.arrowCornerBottom),
      ),
    ];

    final linkArrowsStatus =
        watchOnly((CardCreatorViewModel vm) => vm.currentCard.linkArrows)
            .nullSafe();
    final helpStep =
        watchOnly((CardCreatorViewModel vm) => vm.helpStep);
    return Stack(
      children: [
        ...linkArrows.map((linkArrow) => GestureDetector(
            onTap: () {
              _cardCreatorViewModel.setLinkArrowAt(linkArrow.index);
            },
            child: helpStep == HelpStep.linkArrows
                ? ClipPath(
                  clipper: PolygonClipper(
                    vertices: linkArrow.vertices,
                    offset: linkArrow.offset,
                  ),
                  child: linkArrowsStatus[linkArrow.index] == true
                      ? Image.asset(linkArrow.imagePath, color: AppColor.helpOverlayColor, colorBlendMode: BlendMode.darken)
                      : Container(
                    decoration: BoxDecoration(
                        color: AppColor.helpOverlayColor,
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.helpOverlayColor,
                            blurRadius: ScreenLayout.editButtonBlurRadius,
                            spreadRadius: ScreenLayout.editButtonSpreadRadius,
                          )
                        ]),
                          width: _cardWidth,
                          height: _cardHeight,
                        ),
                )
                : ClipPath(
                    clipper: PolygonClipper(
                      vertices: linkArrow.vertices,
                      offset: linkArrow.offset,
                    ),
                    child: linkArrowsStatus[linkArrow.index] == true
                        ? Image.asset(linkArrow.imagePath)
                        : Container(
                            color: Colors.transparent,
                            width: _cardWidth,
                            height: _cardHeight,
                          ),
                  )))
      ],
    );
  }
}
