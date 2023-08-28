import 'package:flutter/material.dart';
import 'package:yugioh_card_creator/application/extensions.dart';

import '../../data/models/view_state.dart';
import '../base/base_view_model.dart';
import '../resources/layout.dart';
import '../resources/strings.dart';
import '../resources/styles.dart';
import '../view_model_states/state_renderer.dart';
import 'common_widgets.dart';

popDialog(BuildContext context) {
  if (ModalRoute.of(context)?.isCurrent != true) {
    Navigator.of(context).pop();
  }
}

void buildViewState(BuildContext context, BaseViewModel viewModel, ViewState viewState) {
  switch (viewState.state) {
    case ViewModelState.loading:
      popDialog(context);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return commonDialog(context, [
                Text(
                  viewState.message.nullSafe(),
                  textAlign: TextAlign.center,
                  style: kCardNameTextStyle.copyWith(
                    color:
                    Theme.of(context).dialogTheme.contentTextStyle?.color,
                  ),
                ),
                SizedBox(height: ScreenLayout.alertDialogPadding),
                Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context)
                          .dialogTheme
                          .contentTextStyle
                          ?.color),
                )
              ]);
            });
      });
      break;
    case ViewModelState.error:
      popDialog(context);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
            context: context,
            builder: (context) {
              return commonDialog(context, [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: ScreenLayout.hugeIconSize,
                  shadows: const [],
                ),
                SizedBox(height: ScreenLayout.alertDialogPadding),
                Text(
                  viewState.message.nullSafe(),
                  textAlign: TextAlign.center,
                  style: kCardNameTextStyle.copyWith(
                    color: Theme.of(context)
                        .dialogTheme
                        .contentTextStyle
                        ?.color,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    dialogDismissButton(context, Strings.ok),
                  ],
                )
              ]);
            })
            .then((_) => viewModel.stateStreamController
            .add(const ViewState(ViewModelState.normal)));
      });
      break;
    case ViewModelState.success:
      popDialog(context);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
            context: context,
            builder: (ctx) => commonDialog(
              context,
              [
                Icon(Icons.check_circle_outline,
                    color: Colors.green,
                    size: ScreenLayout.hugeIconSize,
                    shadows: const []),
                SizedBox(height: ScreenLayout.alertDialogPadding),
                Text(
                  viewState.message.nullSafe(),
                  textAlign: TextAlign.center,
                  style: kCardNameTextStyle.copyWith(
                    color: Theme.of(context)
                        .dialogTheme
                        .contentTextStyle
                        ?.color,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    dialogDismissButton(context, Strings.ok),
                  ],
                )
              ],
            )).then((_) => viewModel.stateStreamController
            .add(const ViewState(ViewModelState.normal)));
      });
      break;
    default:
      popDialog(context);
  }
}
