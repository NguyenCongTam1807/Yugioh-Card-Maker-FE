import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yugioh_card_creator/application/extensions.dart';

import '../../../application/dependency_injection.dart';
import '../../resources/styles.dart';
import '../card_constants.dart';
import '../card_creator_view_model.dart';

class Atk extends StatefulWidget {
  const Atk({Key? key}) : super(key: key);

  @override
  State<Atk> createState() => _AtkState();
}

class _AtkState extends State<Atk> {
  TextEditingController atkController = TextEditingController();

  @override
  void initState() {
    atkController.value = TextEditingValue(text: _cardCreatorViewModel.currentCard.atk.nullSafe());
    super.initState();
  }

  @override
  void dispose() {
    atkController.dispose();
    super.dispose();
  }

  final _cardCreatorViewModel = getIt<CardCreatorViewModel>();
  final _cardSize = getIt<CardCreatorViewModel>().cardSize;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: _cardSize.width*CardConstants.atkWidth,
      height: _cardSize.width*CardConstants.atkWidth,
      child: TextField(
        maxLength: 4,
        textAlign: TextAlign.right,
        controller: atkController,
        onSubmitted: (String atk) {
          _cardCreatorViewModel.setCardAtk(atk);
        },
        style: kAtkDefTextStyle,
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.all(0),
          border: InputBorder.none,
          counterText: "",
        ),
      ),
    );
  }
}
