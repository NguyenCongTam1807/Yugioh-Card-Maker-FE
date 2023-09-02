
import 'package:dartz/dartz.dart';
import '../../data/models/uploaded_yugioh_card.dart';
import '../../data/network/failure.dart';
import '../repository/gallery_repository.dart';
import 'base_use_case.dart';

class FetchPageUseCase extends BaseUseCase<int, List<UploadedYugiohCard>> {
  final GalleryRepository _galleryRepository;

  FetchPageUseCase(this._galleryRepository);

  @override
  Future<Either<Failure, List<UploadedYugiohCard>>> execute(input) async {
    return await _galleryRepository.fetchPage(input);
  }
}