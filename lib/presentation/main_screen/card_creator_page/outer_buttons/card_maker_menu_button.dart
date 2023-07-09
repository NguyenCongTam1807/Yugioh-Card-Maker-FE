import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yugioh_card_creator/application/extensions.dart';
import 'package:yugioh_card_creator/data/network/yugioh_api.dart';
import 'package:yugioh_card_creator/presentation/main_screen/card_creator_page/card_creator_view_model.dart';
import 'dart:ui' as ui;

import '../../../../application/dependency_injection.dart';
import '../../../resources/layout.dart';
import '../../../resources/strings.dart';
import '../../../resources/styles.dart';

class CardMakerMenuButton extends StatefulWidget with GetItStatefulWidgetMixin {
  CardMakerMenuButton({Key? key}) : super(key: key);

  @override
  State<CardMakerMenuButton> createState() => _CardMakerMenuButtonState();
}

class _CardMakerMenuButtonState extends State<CardMakerMenuButton> with GetItStateMixin {
  final _cardCreatorViewModel = getIt<CardCreatorViewModel>();
  //final _key = getIt<CardCreatorViewModel>().helpItemKeyMap[HelpStep.saveCardButton];
  final _savedFileNameController = TextEditingController();
  final dio = Dio();
  late final String _appDirectoryPath;
  bool isInit = false;

  @override
  Future<void> didChangeDependencies() async {
    if (!isInit) {
      _appDirectoryPath =
          await getApplicationDocumentsDirectory().then((value) => value.path);

      isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _savedFileNameController.dispose();
    super.dispose();
  }

  void _showHelp() {
    _cardCreatorViewModel.startHelp();
  }

  Future<void> _promptImageName() async {
    await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Container(
              padding: EdgeInsets.all(ScreenLayout.alertDialogPadding),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Theme.of(context).dialogTheme.backgroundColor.nullSafe(),
                Theme.of(context).dialogTheme.surfaceTintColor.nullSafe(),
                Theme.of(context).dialogTheme.backgroundColor.nullSafe(),
              ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    Strings.saveYugiohCard,
                    style: kCardNameTextStyle.copyWith(
                      color:
                          Theme.of(context).dialogTheme.contentTextStyle?.color,
                    ),
                  ),
                  TextField(
                    controller: _savedFileNameController,
                    style: TextStyle(
                      color:
                          Theme.of(context).dialogTheme.contentTextStyle?.color,
                    ),
                    decoration: InputDecoration(
                        labelText: Strings.fileName,
                        labelStyle: TextStyle(
                          color: Theme.of(context)
                              .dialogTheme
                              .contentTextStyle
                              ?.color,
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: (Theme.of(context)
                                  .dialogTheme
                                  .contentTextStyle
                                  ?.color)
                              .nullSafe(),
                        ))),
                    onTapOutside: (_) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                  SizedBox(height: ScreenLayout.alertDialogPadding * 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).dialogTheme.iconColor,
                            foregroundColor: Theme.of(context)
                                .dialogTheme
                                .titleTextStyle
                                ?.color,
                          ),
                          onPressed: () {
                            _savedFileNameController.text =
                                DateFormat('yyyy-MM-dd HH:mm:ss:SSS')
                                    .format(DateTime.now());
                          },
                          child: const Text(
                            Strings.useTimestamp,
                            textAlign: TextAlign.center,
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).dialogTheme.iconColor,
                            foregroundColor: Theme.of(context)
                                .dialogTheme
                                .titleTextStyle
                                ?.color,
                          ),
                          onPressed: () async {
                            Navigator.of(context).pop();
                            await _exportImage(_savedFileNameController.text);
                          },
                          child: const Text(Strings.export)),
                    ],
                  )
                ],
              ),
            ),
          );
        });
    _savedFileNameController.clear();
  }

  Future<bool> _exportImage(String fileName) async {
    try {
      final RenderRepaintBoundary boundary =
          _cardCreatorViewModel.cardKey.currentContext?.findRenderObject()
              as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 2.0);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List? pngBytes = byteData?.buffer.asUint8List();

      if (pngBytes != null) {
        final savedFilePath = "$_appDirectoryPath/$fileName.png";
        await File(savedFilePath).create(recursive: true).then(
            (createdEmptyFile) => createdEmptyFile.writeAsBytes(pngBytes));
        final result = await GallerySaver.saveImage(savedFilePath);

        if (result == true && mounted) {
          await showDialog(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  content: Container(
                    padding: EdgeInsets.all(ScreenLayout.alertDialogPadding),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Theme.of(context)
                            .dialogTheme
                            .backgroundColor
                            .nullSafe(),
                        Theme.of(context)
                            .dialogTheme
                            .surfaceTintColor
                            .nullSafe(),
                        Theme.of(context)
                            .dialogTheme
                            .backgroundColor
                            .nullSafe(),
                      ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${Strings.imageSaveSuccess}\n$savedFilePath',
                          style: kSettingTextStyle,
                        ),
                        SizedBox(
                          height: ScreenLayout.alertDialogPadding * 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).dialogTheme.iconColor,
                                  foregroundColor: Theme.of(context)
                                      .dialogTheme
                                      .titleTextStyle
                                      ?.color,
                                ),
                                onPressed: () async {
                                  await _shareImage(savedFilePath);
                                },
                                child: const Text(
                                  Strings.share,
                                )),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).dialogTheme.iconColor,
                                  foregroundColor: Theme.of(context)
                                      .dialogTheme
                                      .titleTextStyle
                                      ?.color,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(Strings.gotIt)),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
          return true;
        }
        return false;
      }
      return false;
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(Strings.somethingWrong),
        action: SnackBarAction(
            label: Strings.ok,
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            }),
      ));
      return false;
    }
  }

  Future<void> _shareImage(String sharedFilePath) async {
    try {
      await Share.shareXFiles([XFile(sharedFilePath)]);
    } catch (err) {
      rethrow;
    }
  }

  Future<void> _uploadCard() async {
    _cardCreatorViewModel.cleanPropertiesPreUpload();

    final response = await dio.post(YugiohApi.uploadCard, data:
      jsonEncode(_cardCreatorViewModel.currentCardJson)
    );

    print("RESPONSE: ${response.statusCode}\n ${response.data}");
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Theme.of(context).colorScheme.onTertiaryContainer,
      padding: EdgeInsets.zero,
      onSelected: (value) async {
        switch (value) {
          case Strings.export:
            _promptImageName();
            break;
          case Strings.upload:
            _uploadCard();
            break;
          case Strings.help:
            _showHelp();
            break;
          default:
            break;
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          appBarMenuItem(Strings.export, Icons.download_for_offline),
          appBarMenuItem(Strings.upload, Icons.cloud_upload),
          appBarMenuItem(Strings.help, Icons.help),
        ];
      },
      child: Icon(Icons.menu, size: ScreenLayout.bigIconSize,),
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
          Text(
            title,
            style: kSettingTextStyle,
          ),
          Icon(iconData,
              color: Theme.of(context).appBarTheme.actionsIconTheme?.color??Colors.black,
              // shadows: []
          ),
        ],
      ),
    );
  }
}
