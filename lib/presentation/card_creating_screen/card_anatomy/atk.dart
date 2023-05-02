import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:yugioh_card_creator/application/extensions.dart';

import '../../../application/dependency_injection.dart';
import '../../resources/strings.dart';
import '../../resources/styles.dart';
import '../positions.dart';
import '../card_creator_view_model.dart';

class Atk extends StatefulWidget with GetItStatefulWidgetMixin{
  Atk({Key? key}) : super(key: key);

  @override
  State<Atk> createState() => _AtkState();
}

class _AtkState extends State<Atk> with GetItStateMixin{
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
  final _cardWidth = getIt<CardCreatorViewModel>().cardSize.width;

  @override
  Widget build(BuildContext context) {
    final atk = watchOnly((CardCreatorViewModel vm) => vm.currentCard.atk).nullSafe();
    atkController.text = atk;
    return SizedBox(
      width: _cardWidth*CardLayout.atkWidth,
      height: _cardWidth*CardLayout.atkHeight,
      child: TextField(
        maxLength: 4,
        textAlign: TextAlign.right,
        controller: atkController,
        onTap: () {
          if (atkController.text == Strings.cardUnknownAtkDef) {
            atkController.text = '';
          }
        },
        onSubmitted: (String atk) {
          FocusManager.instance.primaryFocus?.unfocus();
          _cardCreatorViewModel.setCardAtk(atk);
        },
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
          _cardCreatorViewModel.setCardAtk(atkController.text);
        },
        style: atk=="?"?kUnknownAtkDefTextStyle:kAtkDefTextStyle,
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
          counterText: "",
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
