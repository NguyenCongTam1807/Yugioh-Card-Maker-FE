import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yugioh_card_creator/presentation/card_creating_screen/card_creator_view_model.dart';
import '../../../application/dependency_injection.dart';
import '../../resources/metrics.dart';
import '../../resources/images.dart';
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
                  const Divider(thickness: Sizes.s2, color: Colors.black,),
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
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black,
          spreadRadius: Sizes.s3,
          blurRadius: Sizes.s7,
        )
      ]),
      child: Image.asset(
        ImagePath.cardImageEditButton,
        width: Sizes.s15,
        fit: BoxFit.contain,
      ),
    ));
  }
}
