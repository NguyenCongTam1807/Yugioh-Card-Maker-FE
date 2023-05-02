import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:yugioh_card_creator/application/extensions.dart';

import '../../../application/dependency_injection.dart';
import '../../resources/strings.dart';
import '../../resources/styles.dart';
import '../positions.dart';
import '../card_creator_view_model.dart';

class Def extends StatefulWidget with GetItStatefulWidgetMixin {
  Def({Key? key}) : super(key: key);

  @override
  State<Def> createState() => _DefState();
}

class _DefState extends State<Def> with GetItStateMixin {
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
    final def = watchOnly((CardCreatorViewModel vm) => vm.currentCard.def);
    defController.text = def.nullSafe();

    return SizedBox(
      width: _cardWidth*CardLayout.atkWidth,
      height: _cardWidth*CardLayout.atkHeight,
      child: TextField(
        maxLength: 4,
        textAlign: TextAlign.right,
        controller: defController,
        onTap: () {
          // if (defController.text == Strings.cardUnknownAtkDef) {
          //   defController.text = '';
          // }
        },
        onSubmitted: (def) {
          FocusManager.instance.primaryFocus?.unfocus();
          _cardCreatorViewModel.setCardDef(def);
        },
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
          _cardCreatorViewModel.setCardDef(defController.text);
        },
        style: def=="?"?kUnknownAtkDefTextStyle:kAtkDefTextStyle,
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
