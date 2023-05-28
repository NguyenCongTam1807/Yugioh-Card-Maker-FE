import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:yugioh_card_creator/application/extensions.dart';
import 'package:yugioh_card_creator/presentation/resources/styles.dart';

import '../../../../../application/dependency_injection.dart';
import '../../card_creator_view_model.dart';
import '../../positions.dart';

class LinkRating extends StatefulWidget with GetItStatefulWidgetMixin{
  LinkRating({Key? key}) : super(key: key);

  @override
  State<LinkRating> createState() => _LinkRatingState();
}

class _LinkRatingState extends State<LinkRating> with GetItStateMixin{
  final _cardCreatorViewModel = getIt<CardCreatorViewModel>();
  final _cardWidth = getIt<CardCreatorViewModel>().cardSize.width;

  final _linkRatingController = TextEditingController();

  bool _focused = false;

  @override
  void initState() {
    _linkRatingController.text = _cardCreatorViewModel.linkRating.toString();
    super.initState();
  }

  @override
  void dispose() {
    _linkRatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final linkRating = watchOnly((CardCreatorViewModel vm) => vm.linkRating).nullSafe();
    if (!_focused) {
      _linkRatingController.text = linkRating.toString();
    }

    return SizedBox(
        width:  _cardWidth*CardLayout.linkRatingWidth,
        height: _cardWidth*CardLayout.linkRatingHeight,
        child: TextField(
          controller: _linkRatingController,
          style: kLinkRatingTextStyle,
          maxLength: 1,
          onTap: () {
            setState(() {
              _focused = true;
            });
          },
          onChanged: (String rating) {
            if (rating.isNotEmpty) {
              _cardCreatorViewModel.setLinkRating(rating);
            }
          },
          onSubmitted: (rating) {
            FocusManager.instance.primaryFocus?.unfocus();
            setState(() {
              _focused = false;
            });
          },
          onTapOutside: _focused?(_) {
            FocusManager.instance.primaryFocus?.unfocus();
            setState(() {
              _focused = false;
            });
          }:null,
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            counterText: "",
          ),
          keyboardType: TextInputType.number,
        ));
  }
}
