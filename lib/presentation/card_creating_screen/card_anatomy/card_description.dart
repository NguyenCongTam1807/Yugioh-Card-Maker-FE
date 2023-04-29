import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yugioh_card_creator/application/extensions.dart';

import '../../../application/dependency_injection.dart';
import '../../resources/styles.dart';
import '../card_constants.dart';
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
  void initState() {
    cardDescController.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    cardDescController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    cardDescController.value =
        TextEditingValue(text: currentCard.description.nullSafe());
    return Container(
      padding: EdgeInsets.zero,
      width: cardSize.width * CardConstants.cardDescriptionWidth,
      height: cardSize.height * CardConstants.cardDescriptionHeight,
      child: TextField(
        controller: cardDescController,
        onSubmitted: (String cardDesc) {
          cardCreatorViewModel.setCardName(cardDesc);
        },
        style: kCardDescTextStyle,
        textAlign: TextAlign.justify,
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
        maxLines: 5,
        keyboardType: TextInputType.multiline,
      ),
    );
  }
}
