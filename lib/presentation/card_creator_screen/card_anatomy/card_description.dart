import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yugioh_card_creator/application/extensions.dart';
import 'package:yugioh_card_creator/data/models/yugioh_card.dart';

import '../../../application/dependency_injection.dart';
import '../../custom_classes/elastic_text_field.dart';
import '../../resources/styles.dart';
import '../positions.dart';
import '../card_creator_view_model.dart';

class CardDescription extends StatefulWidget {
  const CardDescription({Key? key}) : super(key: key);

  @override
  State<CardDescription> createState() => _CardDescriptionState();
}

class _CardDescriptionState extends State<CardDescription> {
  TextEditingController cardDescController = TextEditingController();

  final cardCreatorViewModel = getIt<CardCreatorViewModel>();
  final currentCard = getIt<CardCreatorViewModel>().currentCard;
  final cardSize = getIt<CardCreatorViewModel>().cardSize;

  @override
  void dispose() {
    cardDescController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    cardDescController.text = currentCard.description.nullSafe();
    final cardTypeGroup = currentCard.cardType.nullSafe().group;
    return SizedBox(
      width: cardSize.width * (1 - 2 * CardLayout.cardDescriptionMargin),
      height: cardSize.width *
          (cardTypeGroup == CardTypeGroup.monster
              ? CardLayout.cardDescriptionHeight
              : CardLayout.cardDescriptionHeightWithoutType),
      child: ElasticTextField(
        width: cardSize.width * (1 - 2 * CardLayout.cardDescriptionMargin),
        height: cardSize.width * CardLayout.cardDescriptionHeight,
        controller: cardDescController,
        onEditingComplete: (cardDesc) {
          FocusManager.instance.primaryFocus?.unfocus();
          cardCreatorViewModel.setCardDescription(cardDesc);
        },
        style: kCardDescTextStyle,
        textAlign: TextAlign.justify,
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
        maxLines: cardTypeGroup == CardTypeGroup.monster?5:8,
      ),
    );
  }
}
