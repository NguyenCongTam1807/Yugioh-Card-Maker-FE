import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yugioh_card_creator/presentation/card_creator_screen/card_creator_view_model.dart';
import 'package:yugioh_card_creator/presentation/resources/styles.dart';
import '../../../application/dependency_injection.dart';
import '../../resources/images.dart';
import '../../resources/layout.dart';
import '../../resources/strings.dart';

class CardImageButton extends StatelessWidget {
  CardImageButton({Key? key}) : super(key: key);

  final _imagePicker = getIt<ImagePicker>();
  final _cardCreatorViewModel = getIt<CardCreatorViewModel>();

  Future _chooseImage(ImageSource source, BuildContext context) async {
    final xFile = await _imagePicker.pickImage(source: source);
    if (xFile != null) {
      if (context.mounted) {
        Navigator.of(context).pop();
      }
      _cardCreatorViewModel.setCardImage(xFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (ctx) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Theme.of(context).primaryColorLight,
                          Theme.of(context).primaryColorDark,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: const [0.5, 1]),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.camera_alt,
                          color: Theme.of(context).iconTheme.color,
                          size: ScreenLayout.smallIconSize,
                          shadows: Theme.of(context).iconTheme.shadows,
                        ),
                        title: Text(
                          Strings.useCamera,
                          style: kCardNameTextStyle.copyWith(
                              fontSize: ScreenLayout.smallIconSize),
                        ),
                        onTap: () async {
                          _chooseImage(ImageSource.camera, context);
                        },
                      ),
                      const Divider(
                        thickness: 2,
                        color: Colors.black,
                      ),
                      ListTile(
                          leading: Icon(
                            Icons.folder,
                            color: Theme.of(context).iconTheme.color,
                            size: ScreenLayout.smallIconSize,
                          ),
                          title: Text(
                            Strings.loadFromStorage,
                            style: kCardNameTextStyle.copyWith(
                                fontSize: ScreenLayout.smallIconSize),
                          ),
                          onTap: () async {
                            _chooseImage(ImageSource.gallery, context);
                          })
                    ],
                  ),
                );
              });
        },
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              spreadRadius: ScreenLayout.editButtonSpreadRadius,
              blurRadius: ScreenLayout.editButtonBlurRadius,
            )
          ]),
          child: Image.asset(
            ImagePath.cardImageEditButton,
            width: ScreenLayout.editButtonWidth,
            fit: BoxFit.contain,
          ),
        ));
  }
}
