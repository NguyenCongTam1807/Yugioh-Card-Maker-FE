import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:yugioh_card_creator/application/extensions.dart';
import 'package:yugioh_card_creator/data/models/yugioh_card.dart';
import 'package:yugioh_card_creator/presentation/resources/styles.dart';

import '../../../application/dependency_injection.dart';
import '../../resources/colors.dart';
import '../../resources/images.dart';
import '../../resources/layout.dart';
import '../card_creator_view_model.dart';

class CardTypeButton extends StatelessWidget with GetItMixin {
  CardTypeButton({Key? key}) : super(key: key);

  final _cardCreatorViewModel = getIt<CardCreatorViewModel>();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        padding: EdgeInsets.zero,
        color: AppColor.editMenuBgColor.toColor(),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              spreadRadius: ScreenLayout.editButtonSpreadRadius,
              blurRadius: ScreenLayout.editButtonBlurRadius,
            )
          ]),
          child: Image.asset(
            ImagePath.cardTypeEditButton,
            width: ScreenLayout.editButtonWidth,
            fit: BoxFit.contain,
          ),
        ),
        onSelected: (cardType) {
          _cardCreatorViewModel.setCardType(cardType);
        },
        itemBuilder: (ctx) {
          final currentCardType = watchOnly((CardCreatorViewModel vm) => vm.currentCard.cardType);

          return CardType.values
              .map((cardType) => PopupMenuItem(
            value: cardType,
                    height: double.minPositive,
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 5),
                    child: _cardTypeMenuItem(cardType, context,
                        decorated: cardType ==
                            currentCardType),
                  ))
              .toList();
        });
  }

  Widget _cardTypeMenuItem(CardType type, BuildContext context,
      {bool decorated = false}) {
    return Container(
      padding: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [type.getMainColor(), Colors.black]),
          boxShadow: [
            if (decorated)
              BoxShadow(
                color: Theme.of(context).primaryColor,
                spreadRadius: 10.sp,
                blurRadius: 15.sp,
              )
          ]),
      width: _cardCreatorViewModel.cardSize.width * ScreenLayout.editPopupMenuWidth,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            type.getName().toUpperCase(),
            style: kMonsterTypeTextStyle.copyWith(color: Colors.white),
          ),
          Image(
              image: ResizeImage(AssetImage(type.getAssetPath()),
                  width: (ScreenLayout.editButtonWidth *
                          ScreenLayout.editPopupItemScaleFactor)
                      .toInt()))
        ],
      ),
    );
  }
}
