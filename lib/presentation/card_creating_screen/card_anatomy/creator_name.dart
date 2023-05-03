import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yugioh_card_creator/application/extensions.dart';

import '../../../application/dependency_injection.dart';
import '../../custom_classes/elastic_text_field.dart';
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
    creatorNameController.text =
        _cardCreatorViewModel.currentCard.creatorName.nullSafe();

    return SizedBox(
        width: _cardSize.width * CardLayout.creatorNameWidth,
        height: _cardSize.width * CardLayout.creatorNameHeight,
        child: ElasticTextField(
          width: _cardSize.width * CardLayout.creatorNameWidth,
          height: _cardSize.width * CardLayout.creatorNameHeight,
          controller: creatorNameController,
          onEditingComplete: (creatorName) {
            FocusManager.instance.primaryFocus?.unfocus();
            _cardCreatorViewModel.setCreatorName(creatorName);
          },
          style: kCreatorNameTextStyle,
          maxLines: 1,
          textAlign: TextAlign.right,
          scaleAlignment: Alignment.centerRight,
          decoration: const InputDecoration(
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
          ),
        )
        );
  }
}
