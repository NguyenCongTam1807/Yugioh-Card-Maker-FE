import 'package:dartz/dartz.dart';
import 'package:yugioh_card_creator/data/models/uploaded_yugioh_card.dart';
import 'package:yugioh_card_creator/domain/usecase/base_use_case.dart';

import '../../data/network/failure.dart';
import '../repository/gallery_repository.dart';

class FetchGalleryUseCase extends BaseUseCase<void, List<UploadedYugiohCard>> {
  final GalleryRepository _galleryRepository;

  FetchGalleryUseCase(this._galleryRepository);

  @override
  Future<Either<Failure, List<UploadedYugiohCard>>> execute(input) async {
    return await _galleryRepository.fetchGallery();
  }
}