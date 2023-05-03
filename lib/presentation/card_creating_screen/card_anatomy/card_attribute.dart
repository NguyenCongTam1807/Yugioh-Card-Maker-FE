import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:yugioh_card_creator/application/extensions.dart';
import 'package:yugioh_card_creator/data/models/yugioh_card.dart';
import 'package:yugioh_card_creator/presentation/card_creating_screen/positions.dart';

import '../../../application/dependency_injection.dart';
import '../../resources/colors.dart';
import '../../resources/durations.dart';
import '../card_creator_view_model.dart';

class CardAttributeIcon extends StatefulWidget with GetItStatefulWidgetMixin {
  CardAttributeIcon({Key? key}) : super(key: key);

  @override
  State<CardAttributeIcon> createState() => _CardAttributeIconState();
}

class _CardAttributeIconState extends State<CardAttributeIcon>
    with GetItStateMixin {
  final _cardCreatorViewModel = getIt<CardCreatorViewModel>();
  final _cardWidth = getIt<CardCreatorViewModel>().cardSize.width;

  final _widgetKey = GlobalKey();
  late final Offset widgetCenter;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final renderBox =
          _widgetKey.currentContext?.findRenderObject() as RenderBox;
      //Center of the Widget
      widgetCenter = renderBox.localToGlobal(
          Offset(renderBox.size.width / 2, renderBox.size.height / 2));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cardAttribute =
        watchOnly((CardCreatorViewModel vm) => vm.currentCard.attribute);
    return GestureDetector(
        key: _widgetKey,
        onTap: () {
          showGeneralDialog(
              barrierColor: Colors.transparent,
              context: context,
              barrierDismissible: true,
              barrierLabel:
                  MaterialLocalizations.of(context).modalBarrierDismissLabel,
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return const SizedBox();
              },
              transitionBuilder: (ctx, a1, a2, widget) {
                const iconMargin = 2.0;
                final iconWidth = _cardWidth *
                    CardLayout.cardAttributeIconSize *
                    CardLayout.attributeScaleFactor;
                final halfDialogWidth =
                    iconWidth * CardLayout.attributeIconsPerRow / 2 +
                        iconMargin * CardLayout.attributeIconsPerRow;
                final halfDialogHeight =
                    iconWidth * CardLayout.attributeIconsPerColumn / 2 +
                        iconMargin * CardLayout.attributeIconsPerColumn;

                final curve = Curves.easeInOut.transform(a1.value);
                return Stack(
                  children: [
                    Positioned(
                      top: widgetCenter.dy - halfDialogHeight,
                      left: widgetCenter.dx - halfDialogWidth,
                      child: Transform.scale(
                        scale: curve,
                        child: Container(
                          color: AppColor.editMenuBgColor.toColor(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                                CardLayout.attributeIconsPerColumn, (rowIndex) {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                    rowIndex ==
                                            CardLayout.attributeIconsPerColumn -
                                                1
                                        ? 1
                                        : CardLayout.attributeIconsPerRow,
                                    (colIndex) {
                                      //Filter out spell and trap attributes
                                  final attribute = CardAttribute.values
                                      .sublist(0, 7)[rowIndex *
                                          CardLayout.attributeIconsPerRow +
                                      colIndex];
                                  return GestureDetector(
                                    onTap: () {
                                      _cardCreatorViewModel
                                          .setCardAttribute(attribute);
                                      Navigator.of(context).pop();
                                    },
                                    child: _cardAttributeIcon(
                                      attribute.getAssetPath(),
                                      scaleFactor:
                                          CardLayout.attributeScaleFactor,
                                      margin: iconMargin,
                                      decorated: cardAttribute == attribute,
                                    ),
                                  );
                                }),
                              );
                            }),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
              transitionDuration:
                  const Duration(milliseconds: Durations.shortAnimation));
        },
        child: _cardAttributeIcon(cardAttribute.nullSafe().getAssetPath()));
  }

  Widget _cardAttributeIcon(String assetPath,
      {double scaleFactor = 1, double margin = 0, bool decorated = false}) {
    final size = _cardWidth * CardLayout.cardAttributeIconSize * scaleFactor;
    return Container(
      margin: EdgeInsets.all(margin),
      width: size,
      height: size,
      decoration: BoxDecoration(
          boxShadow: [
            if (decorated)
              BoxShadow(
                color: Theme.of(context).primaryColor,
                spreadRadius: 10.sp,
                blurRadius: 15.sp,
              )
          ],
          image: DecorationImage(
            image: AssetImage(assetPath),
            fit: BoxFit.contain,
          )),
    );
  }
}
