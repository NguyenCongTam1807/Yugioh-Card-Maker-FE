import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yugioh_card_creator/application/extensions.dart';

import '../../../application/dependency_injection.dart';
import '../../resources/styles.dart';
import '../card_constants.dart';
import '../card_creator_view_model.dart';

class Def extends StatefulWidget {
  const Def({Key? key}) : super(key: key);

  @override
  State<Def> createState() => _DefState();
}

class _DefState extends State<Def> {
  TextEditingController defController = TextEditingController();

  final _cardCreatorViewModel = getIt<CardCreatorViewModel>();
  final _currentCard = getIt<CardCreatorViewModel>().currentCard;
  final _cardWidth = getIt<CardCreatorViewModel>().cardSize.width;

  @override
  void initState() {
    defController.value = TextEditingValue(text: _currentCard.def.nullSafe());
    super.initState();
  }

  @override
  void dispose() {
    defController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: _cardWidth*CardConstants.atkWidth,
      height: _cardWidth*CardConstants.atkHeight,
      child: TextField(
        maxLength: 4,
        textAlign: TextAlign.right,
        controller: defController,
        onSubmitted: (String def) {
          _cardCreatorViewModel.setCardDef(def);
        },
        style: kAtkDefTextStyle,
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
          counterText: "",
        ),
      ),
    );
  }
}