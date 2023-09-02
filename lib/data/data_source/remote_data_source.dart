import 'package:yugioh_card_creator/data/models/yugioh_card.dart';

import '../models/uploaded_yugioh_card.dart';
import '../network/rest_client.dart';

abstract class RemoteDataSource {
  Future<List<UploadedYugiohCard>> fetchGallery();
  Future<List<UploadedYugiohCard>> fetchPage(int page);
  Future<int> uploadCard(YugiohCard yugiohCard);
}

class RemoteDataSourceImpl implements RemoteDataSource{
  final RestClient _restClient;

  const RemoteDataSourceImpl(this._restClient);

  @override
  Future<List<UploadedYugiohCard>> fetchGallery() async {
    try {
      return await _restClient.fetchGallery();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<UploadedYugiohCard>> fetchPage(int page) async {
    try {
      return await _restClient.fetchPage(page);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<int> uploadCard(YugiohCard yugiohCard) async {
    try {
      return await _restClient.uploadCard(yugiohCard);
    } catch (_) {
      rethrow;
    }
  }
}