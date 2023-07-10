import 'package:flutter/cupertino.dart';

popDialog(BuildContext context) {
  if (ModalRoute.of(context)?.isCurrent != true) {
    Navigator.of(context).pop();
  }
}