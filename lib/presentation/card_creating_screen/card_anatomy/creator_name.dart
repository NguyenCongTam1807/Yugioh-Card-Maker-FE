import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../application/dependency_injection.dart';
import '../../resources/styles.dart';
import '../positions.dart';
import '../card_creator_view_model.dart';

class CreatorName extends StatefulWidget {
  const CreatorName({Key? key}) : super(key: key);

  @override
  State<CreatorName> createState() => _CreatorNameState();
}

class _CreatorNameState extends State<CreatorName> {
  TextEditingController creatorNameController = TextEditingController();

  @override
  void dispose() {
    creatorNameController.dispose();
    super.dispose();
  }

  final _cardCreatorViewModel = getIt<CardCreatorViewModel>();
  final _cardSize = getIt<CardCreatorViewModel>().cardSize;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: _cardSize.width*CardLayout.creatorNameWidth,
      height: _cardSize.width*CardLayout.creatorNameHeight,
      child: TextField(
        textAlign: TextAlign.right,
        controller: creatorNameController,
        onSubmitted: (creatorName) {
          FocusManager.instance.primaryFocus?.unfocus();
          _cardCreatorViewModel.setCreatorName(creatorName);
        },
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
          _cardCreatorViewModel.setCreatorName(creatorNameController.text);
        },
        style: kCreatorNameTextStyle,
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.all(0),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
