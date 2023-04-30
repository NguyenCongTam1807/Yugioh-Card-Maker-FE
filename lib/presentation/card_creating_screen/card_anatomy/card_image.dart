import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yugioh_card_creator/application/extensions.dart';

import '../../../application/dependency_injection.dart';
import '../../resources/card_defaults.dart';
import '../../resources/images.dart';
import '../../resources/strings.dart';
import '../positions.dart';
import '../card_creator_view_model.dart';

class CardImage extends StatelessWidget {
  const CardImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      child: ImageContainer(),
    );
  }
}

class ImageContainer extends StatelessWidget with GetItMixin {
  ImageContainer({Key? key}) : super(key: key);

  final _cardImageSize = getIt<CardCreatorViewModel>().cardSize.width *
      CardPos.cardImageSize;

  @override
  Widget build(BuildContext context) {
    final cardImagePath =
        watchOnly((CardCreatorViewModel vm) => vm.currentCard.imagePath);
    final formattedPath = (cardImagePath ?? CardDefaults.defaultCardImage).trim();
    return SizedBox(
      width: _cardImageSize,
      height: _cardImageSize,
      child: _getCorrectImageType(formattedPath)
    );
  }

  Image _getCorrectImageType(String path) {
    if (path.startsWith(ImagePath.basePath)) {
      return Image.asset(path, fit: BoxFit.cover,);
    } else if (path.startsWith('http')) {
      return Image.network(path, fit: BoxFit.cover,);
    }
    return Image.file(File(path), fit: BoxFit.cover,);
  }
}
