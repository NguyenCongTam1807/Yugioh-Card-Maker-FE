import 'package:dartz/dartz.dart';
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

    (await _storageRepository.uploadImagesToStorage(input)).fold((failure) {
      return failure;
    }, (key) {
      yugiohCard.storageKey = key;
    });

    return await _galleryRepository.uploadCard(yugiohCard);
  }
}
