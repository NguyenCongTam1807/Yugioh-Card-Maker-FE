import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:yugioh_card_creator/presentation/main_screen/main_screen_view_model.dart';

import '../resources/layout.dart';
import '../resources/routes.dart';
import '../resources/strings.dart';
import '../resources/styles.dart';
import 'card_creator_page/card_creator_view.dart';

class MainScreenView extends StatelessWidget with GetItMixin {
  MainScreenView({Key? key}) : super(key: key);

  final List<Widget> _pages = const [
    CardCreatorView(),
  ];

  void _showHelp() {

  }

  @override
  Widget build(BuildContext context) {
    final currentPageIndex = watchOnly((MainScreenViewModel vm) => vm.currentPageIndex);

    final appBar = AppBar(
      title: Transform.scale(
          scaleX: 0.9,
          alignment: Alignment.centerLeft,
          child: const Text(Strings.appName)),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 20.sp),
          child: PopupMenuButton(
            color: Theme.of(context).colorScheme.onTertiaryContainer,
            padding: EdgeInsets.zero,
            // constraints: BoxConstraints(
            //     maxWidth: _cardCreatorViewModel.cardSize.width *
            //         ScreenLayout.effectTypePopupMenuWidth),
            onSelected: (value) {
              switch (value) {
                case Strings.settings:
                  Navigator.of(context).pushNamed(RouteNames.settings);
                  break;
                case Strings.help: _showHelp();
                break;
                default:
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                appBarMenuItem(Strings.settings, Icons.settings),
                appBarMenuItem(Strings.help, Icons.help),
              ];
            },
            child: const Icon(Icons.menu),
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: _pages[currentPageIndex],
    );
  }

  PopupMenuItem<String> appBarMenuItem(String title, IconData iconData) {
    return PopupMenuItem<String>(
      value: title,
      height: double.minPositive,
      padding: EdgeInsets.all(ScreenLayout.editPopupItemPaddingLarge),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: kSettingTextStyle,),
          Icon(iconData),
        ],
      ),
    );
  }
}
