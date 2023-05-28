import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yugioh_card_creator/application/extensions.dart';

import '../../../application/dependency_injection.dart';
import '../../resources/images.dart';
import '../../resources/layout.dart';
import '../../resources/routes.dart';
import '../../resources/strings.dart';
import '../../resources/styles.dart';
import 'card_widget/yugioh_card_widget.dart';
import 'edit_buttons/card_type_button.dart';
import 'positions.dart';
import 'card_creator_view_model.dart';
import 'edit_buttons/card_image_button.dart';

class CardCreatorView extends StatefulWidget {
  const CardCreatorView({Key? key}) : super(key: key);

  @override
  State<CardCreatorView> createState() => _CardCreatorViewState();
}

class _CardCreatorViewState extends State<CardCreatorView> {
  final _cardCreatorViewModel = getIt<CardCreatorViewModel>();
  final _savedFileNameController = TextEditingController();
  final _cardKey = GlobalKey();
  late final String _appDirectoryPath;
  @override
  void initState() {
    _cardCreatorViewModel.init();
    super.initState();
  }

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
    _cardCreatorViewModel.dispose();
    _savedFileNameController.dispose();
    super.dispose();
  }

  void _setCardLayout(double screenWidth, double screenHeight) {
    const cardWidthRatio = ScreenPos.cardWidthRatio;
    const cardHeightRatio = ScreenPos.cardHeightRatio;
    const widthHeightRatio =
        ScreenPos.cardWidthRatio / ScreenPos.cardHeightRatio;
    const marginRatio = ScreenPos.cardMarginRatio;

    late final double cardHeight;
    late final double cardWidth;

    if (screenHeight / cardHeightRatio > screenWidth / cardWidthRatio) {
      cardWidth = screenWidth * (1 - marginRatio);
      cardHeight = cardWidth / widthHeightRatio;
    } else {
      cardHeight = screenHeight * (1 - marginRatio);
      cardWidth = cardHeight * widthHeightRatio;
    }
    kAtkDefTextStyle = kAtkDefTextStyle.copyWith(
        fontSize: CardLayout.atkDefBaseFontSize * cardHeight);
    kUnknownAtkDefTextStyle = kUnknownAtkDefTextStyle.copyWith(
        fontSize: CardLayout.unknownAtkDefBaseFontSize * cardHeight);

    _cardCreatorViewModel.cardSize = Size(cardWidth, cardHeight);
    _cardCreatorViewModel.cardOffset =
        Offset((screenWidth - cardWidth) / 2, (screenHeight - cardHeight) / 2);
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
          _cardKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
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

  void _showHelp() {

  }

  @override
  Widget build(BuildContext context) {
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
            constraints: BoxConstraints(
                maxWidth: _cardCreatorViewModel.cardSize.width *
                    ScreenLayout.effectTypePopupMenuWidth),
            onSelected: (value) {
              switch (value) {
                case 0:
                  Navigator.of(context).pushNamed(RouteNames.settings);
                  break;
                case 1: _showHelp();
                  break;
                default:
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                appBarMenuItem(0, Strings.settings, Icons.settings),
                appBarMenuItem(1, Strings.help, Icons.help),
              ];
            },
            child: const Icon(Icons.menu),
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: Center(child: SingleChildScrollView(
        child: LayoutBuilder(builder: (ctx, constraint) {
          final deviceHeight =
              ui.window.physicalSize.longestSide / ui.window.devicePixelRatio;
          final double statusBarHeight =
              ui.window.padding.top / ui.window.devicePixelRatio;
          final screenHeight =
              deviceHeight - appBar.preferredSize.height - statusBarHeight;

          final screenWidth = constraint.maxWidth;

          if (screenWidth >= screenHeight) {
            return Center(
                child: Image.asset(
              ImagePath.cardImagePlaceHolder,
              fit: BoxFit.scaleDown,
            ));
          }
          _setCardLayout(screenWidth, screenHeight);
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.primary,
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
            width: screenWidth,
            height: screenHeight,
            child: LayoutBuilder(builder: (context, constraint) {
              final cardWidth = _cardCreatorViewModel.cardSize.width;
              final cardHeight = _cardCreatorViewModel.cardSize.height;
              final cardLeft = _cardCreatorViewModel.cardOffset.dx;
              final cardTop = _cardCreatorViewModel.cardOffset.dy;
              final iconLeft =
                  (screenWidth - cardWidth - ScreenLayout.editButtonWidth * 2) /
                      4;

              return Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: _promptImageName,
                        icon: Icon(
                          Icons.save,
                          size: ScreenLayout.bigIconSize,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                      top: cardTop, left: iconLeft, child: CardTypeButton()),
                  Positioned(
                      top: cardTop + cardHeight - ScreenLayout.editButtonHeight,
                      left: iconLeft,
                      child: CardImageButton()),
                  Positioned(
                    top: cardTop,
                    left: cardLeft,
                    child: SizedBox(
                        width: cardWidth,
                        height: cardHeight,
                        child: RepaintBoundary(
                            key: _cardKey, child: YugiohCardWidget())),
                  ),
                ],
              );
            }),
          );
        }),
      )),
    );
  }

  PopupMenuItem<int> appBarMenuItem(int value, String title, IconData iconData) {
    return PopupMenuItem<int>(
      value: value,
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
