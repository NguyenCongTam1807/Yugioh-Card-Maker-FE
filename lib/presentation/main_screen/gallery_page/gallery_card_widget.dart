import 'package:flutter/material.dart';
import 'package:yugioh_card_creator/application/extensions.dart';
import 'package:yugioh_card_creator/data/models/uploaded_yugioh_card.dart';

import '../../resources/defaults.dart';

class GalleryCardWidget extends StatelessWidget {
  final UploadedYugiohCard card;
  const GalleryCardWidget(this.card, {super.key});

  @override
  Widget build(BuildContext context) {
    const errorAlert = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.dangerous_outlined, color: Colors.red,),
        SizedBox(
          height: 8.0,
        ),
        Text("Image not found")
      ],
    );
    return Image.network(
      card.yugiohCard?.thumbnailUrl ?? "",
      errorBuilder: (ctx, object, stackTrace) =>
          Stack(alignment: AlignmentDirectional.center, children: [
        Image.asset(
          CardDefaults.defaultCardType.nullSafe().getAssetPath(),
          errorBuilder: (ctx, object, stackTrace) => errorAlert,
        ),
        errorAlert
      ]),
      fit: BoxFit.fitHeight,
    );
  }
}
