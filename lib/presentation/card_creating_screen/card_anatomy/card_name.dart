import 'package:flutter/material.dart';
import 'package:yugioh_card_creator/application/extensions.dart';
import 'package:yugioh_card_creator/presentation/card_creating_screen/card_constants.dart';

import '../../../application/dependency_injection.dart';
import '../../resources/styles.dart';
import '../card_creator_view_model.dart';

class CardName extends StatefulWidget {
  const CardName({Key? key}) : super(key: key);

  @override
  State<CardName> createState() => _CardNameState();

}

class _CardNameState extends State<CardName> {

  TextEditingController cardNameController = TextEditingController();

  @override
  void initState() {
    cardNameController.text = _cardCreatorViewModel.currentCard.name.nullSafe();
    super.initState();
  }

  @override
  void dispose() {
    cardNameController.dispose();
    super.dispose();
  }

  final _cardCreatorViewModel = getIt<CardCreatorViewModel>();
  final _cardSize = getIt<CardCreatorViewModel>().cardSize;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: _cardSize.width*CardConstants.cardNameWidth,
      height: _cardSize.width*CardConstants.cardNameHeight,
      child: TextField(
        controller: cardNameController,
        onSubmitted: (String cardName) {
          _cardCreatorViewModel.setCardName(cardName);
        },
        style: kCardNameTextStyle,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
}
