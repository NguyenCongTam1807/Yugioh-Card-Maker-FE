import 'package:flutter/material.dart';
import 'package:yugioh_card_creator/data/models/uploaded_yugioh_card.dart';

import '../../../application/dependency_injection.dart';

class GalleryCardWidget extends StatelessWidget {
  final UploadedYugiohCard card;
  const GalleryCardWidget(this.card, {super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(
        card.yugiohCard?.thumbnailUrl??"",
    fit: BoxFit.fitHeight,);
  }
}
