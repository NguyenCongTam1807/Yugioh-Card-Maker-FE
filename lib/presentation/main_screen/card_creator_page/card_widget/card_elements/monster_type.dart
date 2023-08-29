import 'package:flutter/material.dart';
import 'package:yugioh_card_creator/application/extensions.dart';
import 'package:yugioh_card_creator/presentation/resources/styles.dart';
import '../../../../../application/dependency_injection.dart';
import '../../positions.dart';
import '../../card_creator_view_model.dart';


//Actually Monster Type and Abilities (if any)
class MonsterType extends StatefulWidget {
  const MonsterType({Key? key})
      : super(key: key);

  @override
  State<MonsterType> createState() => _MonsterTypeState();
}

class _MonsterTypeState extends State<MonsterType> {
  TextEditingController monsterTypeController = TextEditingController();

  final _cardCreatorViewModel = getIt<CardCreatorViewModel>();
  final _currentCard = getIt<CardCreatorViewModel>().currentCard;
  final _cardWidth = getIt<CardCreatorViewModel>().cardSize.width;
  bool _focused = false;

  @override
  void initState() {
    monsterTypeController.value = TextEditingValue(
        text: _currentCard.monsterType.nullSafe().isEmpty ? '' : '[${_currentCard.monsterType}]');
    super.initState();
  }

  @override
  void dispose() {
    monsterTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: _cardWidth*CardLayout.monsterTypeWidth,
      height: _cardWidth*CardLayout.monsterTypeHeight,
      child: TextField(
        controller: monsterTypeController,
        onSubmitted: (String value) {
          FocusManager.instance.primaryFocus?.unfocus();
          _cardCreatorViewModel.setCardMonsterType(value.substring(1,monsterTypeController.text.length-1));
          setState(() {
            _focused = false;
          });
        },
        onTap: () {
          setState(() {
            _focused = true;
          });
        },
        onTapOutside: _focused?(_) {
          FocusManager.instance.primaryFocus?.unfocus();
          setState(() {
            _focused = false;
          });
        }:null,
        style: kMonsterTypeTextStyle,
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
