import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yugioh_card_creator/application/extensions.dart';
import 'package:yugioh_card_creator/presentation/resources/styles.dart';
import 'package:yugioh_card_creator/presentation/settings_screen/settings_view_model.dart';

import '../../application/dependency_injection.dart';
import '../resources/layout.dart';
import '../resources/routes.dart';
import '../resources/strings.dart';
import '../resources/themes.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final _settingsViewModel = getIt<SettingsViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.settingsScreenTitle),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Theme.of(context).colorScheme.primaryContainer,
          Theme.of(context).colorScheme.secondaryContainer
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: Text(
                Strings.customization,
                style: kSettingGroupTextStyle,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.color_lens),
              title: Text(
                Strings.theme,
                style: kSettingTextStyle,
              ),
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (ctx) {
                      return Container(
                        color: Theme.of(context).primaryColorDark,
                        constraints: BoxConstraints(maxHeight: window.physicalSize.longestSide/window.devicePixelRatio/2,),
                        padding: EdgeInsets.only(top: 20.sp),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ...List.generate(AppTheme.values.length, (index) {
                                final theme = AppTheme.values[index];
                                return InkWell(
                                  onTap: () {
                                    _settingsViewModel.setAppTheme(theme);
                                    Navigator.of(context).popUntil(ModalRoute.withName(RouteNames.settings));
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.sp),
                                    ),
                                    elevation: 10.sp,
                                    color: Theme.of(context).iconTheme.color,
                                    shadowColor: Theme.of(context).shadowColor,
                                    margin: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            theme.getName(),
                                            style: kSettingTextStyle.copyWith(
                                              color: Theme.of(context).colorScheme.onPrimaryContainer
                                            ),
                                          ),
                                          Container(
                                            width:ScreenLayout.themePreviewSize,
                                            height:ScreenLayout.themePreviewSize,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(image: AssetImage(
                                                  theme.getAssetPath(),
                                                )),
                                                borderRadius: BorderRadius.circular(ScreenLayout.themePreviewSize/8)
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      );
                    });
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
