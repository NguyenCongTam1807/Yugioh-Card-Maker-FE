import 'package:flutter/material.dart';
import 'package:yugioh_card_creator/application/extensions.dart';

import '../resources/layout.dart';

Widget commonDialog(BuildContext context, List<Widget> widgetsColumn) {
  return AlertDialog(
    contentPadding: EdgeInsets.zero,
    content: Container(
      padding: EdgeInsets.all(ScreenLayout.alertDialogPadding),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Theme.of(context).dialogTheme.backgroundColor.nullSafe(),
          Theme.of(context).dialogTheme.surfaceTintColor.nullSafe(),
          Theme.of(context).dialogTheme.backgroundColor.nullSafe(),
        ], begin: Alignment.topRight, end: Alignment.bottomLeft),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: widgetsColumn),
    ),
  );
}

Widget dialogActionButton(BuildContext context, String text, Function() onPressedFn) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).dialogTheme.iconColor,
        foregroundColor: Theme.of(context).dialogTheme.titleTextStyle?.color,
      ),
      onPressed: onPressedFn,
      child: Text(
        text,
      ));
}

Widget dialogDismissButton(BuildContext context, String text) {
  return dialogActionButton(context, text, () {
    Navigator.of(context).pop();
  });
}
