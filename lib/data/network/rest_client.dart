import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:yugioh_card_creator/data/models/uploaded_yugioh_card.dart';
import 'package:yugioh_card_creator/data/network/yugioh_api.dart';

import '../models/yugioh_card.dart';

// part 'rest_client.g.dart';

// @RestApi(baseUrl: YugiohApi.baseUrl)
// abstract class RestClient {
//   factory RestClient(Dio dio, {required String baseUrl}) = _RestClient;
//
//   @GET('/cards')
//   Future<List<UploadedYugiohCard>> fetchGallery();
//
//   @POST('/cards')
//   Future<int> uploadCard(
//       @Field("yugioh_card") YugiohCard yugiohCard
//       );
// }

abstract class RestClient {
  Future<List<UploadedYugiohCard>> fetchGallery();
  Future<int> uploadCard(YugiohCard yugiohCard);
}