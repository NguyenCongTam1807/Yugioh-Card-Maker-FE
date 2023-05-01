import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:yugioh_card_creator/application/extensions.dart';
import 'package:yugioh_card_creator/data/models/yugioh_card.dart';
import 'package:yugioh_card_creator/presentation/resources/const_metrics.dart';
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
              spreadRadius: Layouts.editButtonSpreadRadius,
              blurRadius: Layouts.editButtonBlurRadius,
            )
          ]),
          child: Image.asset(
            ImagePath.cardTypeEditButton,
            width: Layouts.editButtonWidth,
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
                        top: ConstInsets.i5, bottom: ConstInsets.i5),
                    child: _cardTypeMenuItem(cardType, context,
                        decorated: cardType ==
                            currentCardType),
                  ))
              .toList();
        });
    // return GestureDetector(
    //     onTap: () {
    //       showGeneralDialog(
    //           barrierColor: Colors.transparent,
    //           context: context,
    //           barrierDismissible: true,
    //           barrierLabel:
    //           MaterialLocalizations.of(context).modalBarrierDismissLabel,
    //           pageBuilder: (BuildContext context, Animation<double> animation,
    //               Animation<double> secondaryAnimation) {
    //             return const SizedBox();
    //           },
    //           transitionBuilder: (ctx, a1, a2, widget) {
    //             const iconMargin = ConstInsets.i2;
    //             final iconWidth = _cardWidth *
    //                 CardPos.cardAttributeIconSize *
    //                 CardPos.attributeScaleFactor;
    //             final halfDialogWidth =
    //                 iconWidth * CardPos.attributeIconsPerRow / 2 +
    //                     iconMargin * CardPos.attributeIconsPerRow;
    //             final halfDialogHeight =
    //                 iconWidth * CardPos.attributeIconsPerColumn / 2 +
    //                     iconMargin * CardPos.attributeIconsPerColumn;
    //
    //             final curve = Curves.easeInOut.transform(a1.value);
    //             return Stack(
    //               children: [
    //                 Positioned(
    //                   top: widgetCenter.dy - halfDialogHeight,
    //                   left: widgetCenter.dx - halfDialogWidth,
    //                   child: Transform.scale(
    //                     scale: curve,
    //                     child: Container(
    //                       color: AppColor.halfBlack.toColor(),
    //                       child: Column(
    //                         mainAxisSize: MainAxisSize.min,
    //                         children: List.generate(
    //                             CardPos.attributeIconsPerColumn, (rowIndex) {
    //                           return Row(
    //                             mainAxisSize: MainAxisSize.min,
    //                             mainAxisAlignment: MainAxisAlignment.center,
    //                             children: List.generate(
    //                                 CardPos.attributeIconsPerRow, (colIndex) {
    //                               final attribute = CardAttribute.values[
    //                               rowIndex * CardPos.attributeIconsPerRow +
    //                                   colIndex];
    //                               return GestureDetector(
    //                                 onTap: () {
    //                                   _cardCreatorViewModel
    //                                       .setCardAttribute(attribute);
    //                                   Navigator.of(context).pop();
    //                                 },
    //                                 child: _cardAttributeIcon(
    //                                   attribute.getAssetPath(),
    //                                   scaleFactor: CardPos.attributeScaleFactor,
    //                                   margin: iconMargin,
    //                                   decorated: cardAttribute == attribute,
    //                                 ),
    //                               );
    //                             }),
    //                           );
    //                         }),
    //                       ),
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             );
    //           },
    //           transitionDuration:
    //           const Duration(milliseconds: Durations.shortAnimation));
    //     },
    //     child: Container(
    //       decoration: BoxDecoration(boxShadow: [
    //         BoxShadow(
    //           color: Theme.of(context).shadowColor,
    //           spreadRadius: Layouts.editButtonSpreadRadius,
    //           blurRadius: Layouts.editButtonBlurRadius,
    //         )
    //       ]),
    //       child: Image.asset(
    //         ImagePath.cardTypeEditButton,
    //         width: Layouts.editButtonWidth,
    //         fit: BoxFit.contain,
    //         scale: 0.3,
    //       ),
    //     ));
  }

  Widget _cardTypeMenuItem(CardType type, BuildContext context,
      {bool decorated = false}) {
    return Container(
      padding: const EdgeInsets.only(left: ConstInsets.i12),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [type.getMainColor(), Colors.black]),
          boxShadow: [
            if (decorated)
              BoxShadow(
                color: Theme.of(context).primaryColor,
                spreadRadius: ConstSizes.s10.sp,
                blurRadius: ConstSizes.s15.sp,
              )
          ]),
      width: _cardCreatorViewModel.cardSize.width * Layouts.editPopupMenuWidth,
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
                  width: (Layouts.editButtonWidth *
                          Layouts.editPopupItemScaleFactor)
                      .toInt()))
        ],
      ),
    );
  }
}
