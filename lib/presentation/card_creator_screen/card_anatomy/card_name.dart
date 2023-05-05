import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:yugioh_card_creator/application/extensions.dart';
import 'package:yugioh_card_creator/presentation/card_creator_screen/positions.dart';
import 'package:yugioh_card_creator/presentation/custom_classes/elastic_text_field.dart';

import '../../../application/dependency_injection.dart';
import '../../resources/styles.dart';
import '../card_creator_view_model.dart';

class CardName extends StatefulWidget with GetItStatefulWidgetMixin{
  CardName({Key? key}) : super(key: key);

  @override
  State<CardName> createState() => _CardNameState();
}

class _CardNameState extends State<CardName> with GetItStateMixin{
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
    final textColor = watchOnly((CardCreatorViewModel vm) => vm.currentCard.cardType).nullSafe().getForegroundColor();

    return SizedBox(
        width: _cardSize.width * CardLayout.cardNameWidth,
        height: _cardSize.width * CardLayout.cardNameHeight,
        child: ElasticTextField(
          width: _cardSize.width * CardLayout.cardNameWidth,
          height: _cardSize.width * CardLayout.cardNameHeight,
          controller: cardNameController,
          onEditingComplete: (cardName) {
            FocusManager.instance.primaryFocus?.unfocus();
            _cardCreatorViewModel.setCardName(cardName);
          },
          style: kCardNameTextStyle.copyWith(color: textColor),
          maxLines: 1,
        ));
  }
}
