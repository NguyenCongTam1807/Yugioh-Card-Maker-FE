import 'package:dartz/dartz.dart';
import 'package:yugioh_card_creator/application/extensions.dart';
import 'package:yugioh_card_creator/data/models/yugioh_card.dart';
import 'package:yugioh_card_creator/data/network/failure.dart';
import 'package:yugioh_card_creator/domain/repository/gallery_repository.dart';
import 'package:yugioh_card_creator/domain/usecase/base_use_case.dart';

import '../repository/storage_repository.dart';

class UploadCardUseCase extends BaseUseCase<Map<String, dynamic>, int> {
  final GalleryRepository _galleryRepository;
  final StorageRepository _storageRepository;
  UploadCardUseCase(this._galleryRepository, this._storageRepository);

  @override
  Future<Either<Failure, int>> execute(Map<String, dynamic> input) async {
    final yugiohCard = input['yugiohCard'] as YugiohCard;
    final oldCardImagePath = yugiohCard.imagePath;
    late String storageKey;

    (await _storageRepository.uploadImageToStorage(input)).fold((failure) {
      return failure;
    }, (keys) async {
      storageKey = keys['storageKey'].nullSafe();
      yugiohCard.imagePath = keys['newImagePath'].nullSafe();
      yugiohCard.thumbnailUrl = keys['thumbnailUrl'].nullSafe();
      yugiohCard.fullCardImageUrl = keys['fullCardImageUrl'].nullSafe();
    });

    final response = await _galleryRepository.uploadCard(yugiohCard);
    if (response.isLeft()) {
      await _storageRepository.removeImagesFromStorage(storageKey);

      yugiohCard.imagePath = oldCardImagePath;
    }

    return response;
  }
}
