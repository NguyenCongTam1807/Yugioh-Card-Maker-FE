import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

import '../../../application/dependency_injection.dart';
import '../../resources/colors.dart';
import '../../resources/layout.dart';
import '../card_creator_page/card_creator_view_model.dart';

class HighlightWrapper extends StatelessWidget with GetItMixin {
  final Widget child;
  final double highlightPadding;
  HighlightWrapper({Key? key, this.highlightPadding = 0.0, required this.child})
      : super(key: key);

  final _helpItemNameMap = getIt<CardCreatorViewModel>().helpItemNameMap;

  @override
  Widget build(BuildContext context) {
    final helpStep = watchOnly((CardCreatorViewModel vm) => vm.helpStep);
    return _helpItemNameMap[helpStep] == child.toString()
        ? Container(
            padding: EdgeInsets.all(highlightPadding),
            decoration:
                BoxDecoration(color: AppColor.helpOverlayColor, boxShadow: [
              BoxShadow(
                color: AppColor.helpOverlayColor,
                blurRadius: ScreenLayout.editButtonBlurRadius,
                spreadRadius: ScreenLayout.editButtonSpreadRadius,
              )
            ]),
            child: child)
        : Padding(
            padding: EdgeInsets.all(highlightPadding),
            child: child,
          );
  }
}
