import 'package:flutter/material.dart';

import '../../../application/dependency_injection.dart';
import '../../resources/images.dart';
import '../card_constants.dart';
import '../card_creator_view_model.dart';

class CardImage extends StatelessWidget {
  CardImage({Key? key}) : super(key: key);

  final currentCard = getIt<CardCreatorViewModel>().currentCard;
  final cardImageSize = getIt<CardCreatorViewModel>().cardSize.width*CardConstants.cardImageSize;
  
  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: cardImageSize,
      height: cardImageSize,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(currentCard.imagePath??ImagePath.defaultCardImage), )
      ),
    );
  }
}
