import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yugioh_card_creator/presentation/card_creating_screen/card_creator_view_model.dart';
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
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: const Text(Strings.useCamera),
                    onTap: () async {
                      _chooseImage(ImageSource.camera, context);
                    },
                  ),
                  const Divider(thickness: 2, color: Colors.black,),
                  ListTile(
                      leading: const Icon(Icons.folder),
                      title: const Text(Strings.loadFromStorage),
                      onTap: () async {
                        _chooseImage(ImageSource.gallery, context);
                      })
                ],
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
