import 'dart:io';
import 'dart:typed_data';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_common/vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:yugioh_card_creator/application/extensions.dart';
import 'package:yugioh_card_creator/data/network/error_handler.dart';

import '../../data/models/yugioh_card.dart';
import '../../data/network/failure.dart';
import '../../presentation/resources/images.dart';
import '../../presentation/resources/strings.dart';

abstract class StorageRepository {
  Future<Either<Failure, String>> uploadImagesToStorage(Map<String, dynamic> input);

  Future<Uint8List> getBytesFromImagePath(String path) async {
    final Uint8List result;
    try {
      if (path.startsWith(ImagePath.baseAssetImagePath)) {
        //asset image
        final ByteData byteData = await rootBundle.load(path);
        result = byteData.buffer.asUint8List();
      } else if (path.startsWith('http')) {
        //network image
        final response = await http.get(Uri.parse(path));
        if (response.statusCode == 200) {
          result = response.bodyBytes;
        } else {
          throw Exception('Error fetching card image from given $path');
        }
      } else {
        //local image
        final file = File(path);
        result = await file.readAsBytes();
      }
    } catch (e) {
      rethrow;
    }

    return result;
  }

// Future<String> getUploadedImageUrl(String key) async {
//   try {
//     final imageUrlResult = await Amplify.Storage.getUrl(key: key).result;
//     return imageUrlResult.url.toString();
//   } catch (e) {
//     rethrow;
//   }
// }
}

class S3StorageRepository extends StorageRepository {
  @override
  Future<Either<Failure, String>> uploadImagesToStorage(
      Map<String, dynamic> input) async {
    final yugiohCard = input['yugiohCard'] as YugiohCard;
    final fullCardImageFile =
        AWSFilePlatform.fromData(input['fullCardImageData']);
    final thumbnailFile = AWSFilePlatform.fromData(input['thumbnailData']);

    try {
      final cardImageData =
          await getBytesFromImagePath(yugiohCard.imagePath.nullSafe());

      final cardImageFile = AWSFilePlatform.fromData(cardImageData);

      final id = UUID.getUUID();
      final storageKey = '${id}_${yugiohCard.name}';
      const options = StorageUploadFileOptions(
        accessLevel: StorageAccessLevel.guest,
      );

      final fullCardKey = 'full-card-image/$storageKey.png';
      final thumbnailKey = 'thumbnail-image/$storageKey.png';
      final cardImageKey = 'card-image/$storageKey.png';

      Amplify.Storage.uploadFile(
        localFile: fullCardImageFile,
        key: fullCardKey,
        options: options,
      );
      Amplify.Storage.uploadFile(
        localFile: thumbnailFile,
        key: thumbnailKey,
        options: options,
      );
      Amplify.Storage.uploadFile(
        localFile: cardImageFile,
        key: cardImageKey,
        options: options,
      );
      return Right(storageKey);
    } catch (_) {
      return const Left(Failure(Strings.uploadFailed));
    }
  }
}
