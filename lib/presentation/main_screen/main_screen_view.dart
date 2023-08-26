import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:yugioh_card_creator/application/extensions.dart';
import 'package:yugioh_card_creator/data/models/view_state.dart';
import 'package:yugioh_card_creator/presentation/common/common_functions.dart';
import 'package:yugioh_card_creator/presentation/common/common_widgets.dart';
import 'package:yugioh_card_creator/presentation/main_screen/card_creator_page/card_creator_view_model.dart';
import 'package:yugioh_card_creator/presentation/main_screen/gallery_page/gallery_view.dart';
import 'package:yugioh_card_creator/presentation/main_screen/main_screen_view_model.dart';
import 'package:yugioh_card_creator/presentation/view_model_states/state_renderer.dart';

import '../../application/dependency_injection.dart';
import '../resources/layout.dart';
import '../resources/routes.dart';
import '../resources/strings.dart';
import '../resources/styles.dart';
import 'card_creator_page/card_creator_view.dart';

class MainScreenView extends StatelessWidget with GetItMixin {
  MainScreenView({Key? key}) : super(key: key);

  final _mainScreenViewModel = getIt<MainScreenViewModel>();
  final _cardCreatorViewModel = getIt<CardCreatorViewModel>();

  final List<Widget> _pages = [
    CardCreatorView(),
    GalleryView(),
  ];

  @override
  Widget build(BuildContext context) {
    final currentPageIndex =
        watchOnly((MainScreenViewModel vm) => vm.currentPageIndex);

    final appBar = AppBar(
      title: Transform.scale(
          scaleX: 0.9,
          alignment: Alignment.centerLeft,
          child: const Text(Strings.appName)),
      actions: [
        IconButton(
            onPressed: () {
              _mainScreenViewModel.changePage(0);
            },
            icon: const Icon(Icons.brush)),
        IconButton(
            onPressed: () {
              _mainScreenViewModel.changePage(1);
            },
            icon: const Icon(Icons.photo_library)),
        IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RouteNames.settings);
            },
            icon: const Icon(Icons.settings)),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: Builder(builder: (context) {
        final viewState = watchStream(
                (CardCreatorViewModel vm) => vm.stateStreamController,
                const ViewState(ViewModelState.normal))
            .data;

        switch (viewState!.state) {
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
                          color: Theme.of(context)
                              .dialogTheme
                              .contentTextStyle
                              ?.color,
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
                .then((_) => _cardCreatorViewModel.stateStreamController
                    .add(const ViewState(ViewModelState.normal)));});
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
                      )).then((_) => _cardCreatorViewModel.stateStreamController
                  .add(const ViewState(ViewModelState.normal)));
            });
            break;
          default:
        }
        return _pages[currentPageIndex];
      }),
    );
  }
}
