import 'package:flutter/material.dart';
import 'package:yugioh_card_creator/data/models/uploaded_yugioh_card.dart';

import '../../../application/dependency_injection.dart';
import 'gallery_view_model.dart';

class GalleryCardWidget extends StatelessWidget {
  final UploadedYugiohCard card;
  GalleryCardWidget(this.card, {super.key});

  final _galleryViewModel = getIt<GalleryViewModel>();

  @override
  Widget build(BuildContext context) {
    return Image.network(card.yugiohCard?.thumbnailUrl??"");
  }
}
