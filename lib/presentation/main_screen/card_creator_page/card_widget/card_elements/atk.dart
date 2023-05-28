import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:yugioh_card_creator/application/extensions.dart';

import '../../../../../application/dependency_injection.dart';
import '../../../../resources/strings.dart';
import '../../../../resources/styles.dart';
import '../../positions.dart';
import '../../card_creator_view_model.dart';

class Atk extends StatefulWidget with GetItStatefulWidgetMixin {
  Atk({Key? key}) : super(key: key);

  @override
  State<Atk> createState() => _AtkState();
}

class _AtkState extends State<Atk> with GetItStateMixin {
  TextEditingController atkController = TextEditingController();

  final _cardCreatorViewModel = getIt<CardCreatorViewModel>();
  final _cardWidth = getIt<CardCreatorViewModel>().cardSize.width;
  bool _focused = false;
  @override
  void initState() {
    atkController.text = _cardCreatorViewModel.currentCard.atk.nullSafe();
    super.initState();
  }

  @override
  void dispose() {
    atkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final atk = watchStream(
        (CardCreatorViewModel vm) => vm.atkStreamController,
        Strings.defaultAtk).data.nullSafe();
    final isAtkUnknown = atk == Strings.cardUnknownAtkDef;
    if (!isAtkUnknown || !_focused) {
      atkController.value = atkController.value.copyWith(text: atk);
    }

    return SizedBox(
      width: _cardWidth * CardLayout.atkWidth,
      height: _cardWidth * CardLayout.atkHeight,
      child: TextField(
        maxLength: 4,
        textAlign: TextAlign.right,
        controller: atkController,
        onTap: () {
          setState(() {
            if (isAtkUnknown) {
              atkController.text = '';
            }
            _focused = true;
          });
        },
        onChanged: (String atk) {
          if (atk.isNotEmpty) {
            _cardCreatorViewModel.setCardAtk(atk);
          }
        },
        onSubmitted: (atk) {
          FocusManager.instance.primaryFocus?.unfocus();
          if (atk.isEmpty) {
            _cardCreatorViewModel.setCardAtk(atk);
          }
          setState(() {
            _focused = false;
          });
        },
        onTapOutside: _focused?(_) {
          FocusManager.instance.primaryFocus?.unfocus();
          if (atkController.text.isEmpty) {
            _cardCreatorViewModel.setCardAtk(atkController.text);
          }
          setState(() {
            _focused = false;
          });
        }:null,
        style: isAtkUnknown?kUnknownAtkDefTextStyle:kAtkDefTextStyle,
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
