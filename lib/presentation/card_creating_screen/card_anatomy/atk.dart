import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yugioh_card_creator/application/extensions.dart';

import '../../../application/dependency_injection.dart';
import '../../resources/styles.dart';
import '../positions.dart';
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
      width: _cardSize.width*CardPos.atkWidth,
      height: _cardSize.width*CardPos.atkWidth,
      child: TextField(
        maxLength: 4,
        textAlign: TextAlign.right,
        controller: atkController,
        onSubmitted: (String atk) {
          FocusManager.instance.primaryFocus?.unfocus();
          _cardCreatorViewModel.setCardAtk(atk);
        },
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
          _cardCreatorViewModel.setCardAtk(atkController.text);
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
