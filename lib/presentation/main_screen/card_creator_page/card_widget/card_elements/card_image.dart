import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

import '../../../../../application/dependency_injection.dart';
import '../../../../resources/colors.dart';
import '../../../../resources/defaults.dart';
import '../../../../resources/images.dart';
import '../../help_step.dart';
import '../../positions.dart';
import '../../card_creator_view_model.dart';

class CardImage extends StatelessWidget {
  const CardImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      maxScale: 10,
      child: ImageContainer(),
    );
  }
}

class ImageContainer extends StatelessWidget with GetItMixin {
  ImageContainer({Key? key}) : super(key: key);
  final _cardImageSize = getIt<CardCreatorViewModel>().cardSize.width *
      CardLayout.cardImageSize;

  @override
  Widget build(BuildContext context) {
    final cardImagePath =
        watchOnly((CardCreatorViewModel vm) => vm.currentCard.imagePath);
    final formattedPath = (cardImagePath ?? CardDefaults.defaultCardImage).trim();
    final inHelpMode = watchOnly((CardCreatorViewModel vm) => vm.helpStep == HelpStep.cardImage);
    return SizedBox(
      width: _cardImageSize,
      height: _cardImageSize,
      child: _getCorrectImageType(formattedPath, helpMode: inHelpMode)
    );
  }

  Image _getCorrectImageType(String path, {helpMode = false}) {
    const boxFit = BoxFit.cover;
    const filterQuality = FilterQuality.medium;
    if (path.startsWith(ImagePath.baseAssetImagePath)) {
      return Image.asset(path, fit: boxFit, filterQuality: filterQuality, color: helpMode?AppColor.helpOverlayColor:null, colorBlendMode: helpMode?BlendMode.darken:null,);
    } else if (path.startsWith('http')) {
      return Image.network(path, fit: boxFit, filterQuality: filterQuality, color: helpMode?AppColor.helpOverlayColor:null, colorBlendMode: helpMode?BlendMode.darken:null,);
    }
    return Image.file(File(path), fit: boxFit, filterQuality: filterQuality, color: helpMode?AppColor.helpOverlayColor:null, colorBlendMode: helpMode?BlendMode.darken:null,);
  }
}
