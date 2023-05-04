import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:yugioh_card_creator/application/extensions.dart';
import 'package:yugioh_card_creator/presentation/resources/card_defaults.dart';

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

  bool _focused = false;

  @override
  void initState() {
    defController.text = _currentCard.def.nullSafe();
    super.initState();
  }

  @override
  void dispose() {
    defController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final def = watchStream((CardCreatorViewModel vm) => vm.defStreamController,
            Strings.defaultDef)
        .data
        .nullSafe();
    final isDefUnknown = def == Strings.cardUnknownAtkDef;
    if (!isDefUnknown || !_focused) {
      defController.value = defController.value.copyWith(text: def);
    }



    return SizedBox(
      width: _cardWidth * CardLayout.atkWidth,
      height: _cardWidth * CardLayout.atkHeight,
      child: TextField(
        maxLength: 4,
        textAlign: TextAlign.right,
        controller: defController,
        onTap: () {
          setState(() {
            if (isDefUnknown) {
              defController.text = '';
            }
            _focused = true;
          });
        },
        onChanged: (String def) {
          if (def.isNotEmpty) {
            _cardCreatorViewModel.setCardDef(def);
          }
        },
        onSubmitted: (def) {
          FocusManager.instance.primaryFocus?.unfocus();
          if (def.isEmpty) {
            _cardCreatorViewModel.setCardDef(def);
          }
          setState(() {
            _focused = false;
          });
        },
        onTapOutside: _focused?(_) {
          FocusManager.instance.primaryFocus?.unfocus();
          if (defController.text.isEmpty) {
            _cardCreatorViewModel.setCardDef(defController.text);
          }
          setState(() {
            _focused = false;
          });
        }:null,
        style: isDefUnknown ? kUnknownAtkDefTextStyle : kAtkDefTextStyle,
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
