import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:yugioh_card_creator/presentation/main_screen/card_creator_page/card_creator_view_model.dart';
import 'package:yugioh_card_creator/presentation/main_screen/gallery_page/gallery_view.dart';
import 'package:yugioh_card_creator/presentation/main_screen/main_screen_view_model.dart';

import '../../application/dependency_injection.dart';
import '../resources/routes.dart';
import '../resources/strings.dart';
import 'card_creator_page/card_creator_view.dart';

class MainScreenView extends StatelessWidget with GetItMixin {
  MainScreenView({Key? key}) : super(key: key);

  final _mainScreenViewModel = getIt<MainScreenViewModel>();

  final List<Widget> _pages = [
    CardCreatorView(),
    const GalleryView(),
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
      body: _pages[currentPageIndex],
    );
  }
}
