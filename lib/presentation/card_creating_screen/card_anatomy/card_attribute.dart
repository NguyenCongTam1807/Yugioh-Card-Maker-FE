import 'package:flutter/material.dart';
import 'package:yugioh_card_creator/application/extensions.dart';
import 'package:yugioh_card_creator/presentation/card_creating_screen/card_constants.dart';

import '../../../application/dependency_injection.dart';
import '../card_creator_view_model.dart';

class CardAttributeIcon extends StatefulWidget {
  const CardAttributeIcon({Key? key}) : super(key: key);

  @override
  State<CardAttributeIcon> createState() => _CardAttributeIconState();
}

class _CardAttributeIconState extends State<CardAttributeIcon> {

  final _cardCreatorViewModel = getIt<CardCreatorViewModel>();
  final _cardSize = getIt<CardCreatorViewModel>().cardSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _cardSize.width*CardConstants.cardAttributeIconSize,
      height: _cardSize.width*CardConstants.cardAttributeIconSize,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                _cardCreatorViewModel.currentCard.attribute.nullSafe().getAssetPath()),
            fit: BoxFit.contain,
          )),
    );
  }
}
