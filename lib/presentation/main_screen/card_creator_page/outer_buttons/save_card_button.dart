import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yugioh_card_creator/application/extensions.dart';
import 'package:yugioh_card_creator/presentation/main_screen/card_creator_page/card_creator_view_model.dart';
import 'dart:ui' as ui;

import '../../../../application/dependency_injection.dart';
import '../../../resources/layout.dart';
import '../../../resources/strings.dart';
import '../../../resources/styles.dart';

class SaveCardButton extends StatefulWidget with GetItStatefulWidgetMixin {
  SaveCardButton({Key? key}) : super(key: key);

  @override
  State<SaveCardButton> createState() => _SaveCardButtonState();
}

class _SaveCardButtonState extends State<SaveCardButton> with GetItStateMixin {
  final _cardCreatorViewModel = getIt<CardCreatorViewModel>();
  final _savedFileNameController = TextEditingController();
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
                          child: const Text(Strings.save)),
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

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _promptImageName,
      icon: Icon(
        Icons.save,
        size: ScreenLayout.bigIconSize,
      ),
    );
  }
}
