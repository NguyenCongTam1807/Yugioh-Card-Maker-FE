import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:yugioh_card_creator/application/extensions.dart';
import 'package:yugioh_card_creator/data/models/yugioh_card.dart';
import 'package:yugioh_card_creator/presentation/card_creating_screen/card_constants.dart';

import '../../../application/dependency_injection.dart';
import '../../resources/durations.dart';
import '../../resources/metrics.dart';
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
  late final Offset widgetOffset;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final renderBox =
          _widgetKey.currentContext?.findRenderObject() as RenderBox;
      widgetOffset = renderBox.localToGlobal(
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
                const iconMargin = Insets.i2;
                final iconWidth = _cardWidth *
                    CardConstants.cardAttributeIconSize *
                    CardConstants.attributeScaleFactor;
                final halfDialogWidth =
                    iconWidth * CardConstants.attributeIconsPerRow / 2 +
                        iconMargin * CardConstants.attributeIconsPerRow;
                final halfDialogHeight =
                    iconWidth * CardConstants.attributeIconsPerColumn / 2 +
                        iconMargin * CardConstants.attributeIconsPerColumn;

                final curve = Curves.easeInOut.transform(a1.value);
                return Stack(
                  children: [
                    Positioned(
                      top: widgetOffset.dy - halfDialogHeight,
                      left: widgetOffset.dx - halfDialogWidth,
                      child: Transform.scale(
                        scale: curve,
                        child: Container(
                          color: Colors.black45,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                                CardConstants.attributeIconsPerColumn,
                                (rowIndex) {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                    CardConstants.attributeIconsPerRow,
                                    (colIndex) {
                                  final iconIndex = rowIndex *
                                          CardConstants.attributeIconsPerRow +
                                      colIndex;
                                  return GestureDetector(
                                    onTap: () {
                                      _cardCreatorViewModel.setCardAttribute(
                                          CardAttribute.values[iconIndex]);
                                      Navigator.of(context).pop();
                                    },
                                    child: _cardAttributeIcon(
                                      CardAttribute.values[iconIndex]
                                          .getAssetPath(),
                                      scaleFactor:
                                          CardConstants.attributeScaleFactor,
                                      margin: iconMargin,
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
              transitionDuration: const Duration(milliseconds: Durations.shortAnimation));
        },
        child: _cardAttributeIcon(cardAttribute.nullSafe().getAssetPath()));
  }

  Widget _cardAttributeIcon(String assetPath,
      {double scaleFactor = 1, double margin = 0}) {
    return Container(
      margin: EdgeInsets.all(margin),
      width: _cardWidth * CardConstants.cardAttributeIconSize * scaleFactor,
      height: _cardWidth * CardConstants.cardAttributeIconSize * scaleFactor,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(assetPath),
        fit: BoxFit.contain,
      )),
    );
  }
}
