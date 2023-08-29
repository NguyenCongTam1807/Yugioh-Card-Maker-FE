import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:aws_common/vm.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:yugioh_card_creator/application/extensions.dart';
import 'package:yugioh_card_creator/data/network/error_handler.dart';

import '../../data/models/yugioh_card.dart';
import '../../data/network/failure.dart';
import '../../data/network/network_info.dart';
import '../../presentation/resources/images.dart';
import '../../presentation/resources/strings.dart';

abstract class StorageRepository {
  Future<Either<Failure, Map<String, String>>> uploadImageToStorage(
      Map<String, dynamic> input);
  Future<Either<Failure, void>> removeImagesFromStorage(String storageKey);
  Future<String> getObjectUrl(String key);

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
}

class S3StorageRepository extends StorageRepository {
  final NetworkInfo _networkInfo;

  S3StorageRepository(this._networkInfo);

  @override
  Future<Either<Failure, Map<String, String>>> uploadImageToStorage(
      Map<String, dynamic> input) async {
    final yugiohCard = input['yugiohCard'] as YugiohCard;
    final fullCardImageFile =
        AWSFilePlatform.fromData(input['fullCardImageData']);
    final thumbnailFile = AWSFilePlatform.fromData(input['thumbnailData']);

    try {
      if (await _networkInfo.isConnected()) {
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
        final newImagePath = await getObjectUrl('card-image/$storageKey.png');
        final thumbnailUrl =
            await getObjectUrl('thumbnail-image/$storageKey.png');
        final fullCardImageUrl =
            await getObjectUrl('full-card-image/$storageKey.png');
        final map = <String, String>{
          'storageKey': storageKey,
          'newImagePath': newImagePath,
          'thumbnailUrl': thumbnailUrl,
          'fullCardImageUrl': fullCardImageUrl,
        };
        return Right(map);
      } else {
        return Left(DataSourceStatus.connectionError.getFailure());
      }
    } catch (_) {
      return const Left(Failure(Strings.uploadFailed));
    }
  }

  @override
  Future<Either<Failure, void>> removeImagesFromStorage(
      String storageKey) async {
    try {
      Amplify.Storage.removeMany(
        keys: [
          'full-card-image/$storageKey.png',
          'thumbnail-image/$storageKey.png',
          'card-image/$storageKey.png'
        ],
        options: const StorageRemoveManyOptions(
          accessLevel: StorageAccessLevel.guest,
        ),
      );
    } catch (_) {
      //TODO: cache the leftover storage key somewhere to be deleted later
      print("Cannot rollback image upload");
    }
    return const Right(Void);
  }

  @override
  Future<String> getObjectUrl(String key) async {
    try {
      final preSignedUrlResult = await Amplify.Storage.getUrl(
        key: key,
        options: const StorageGetUrlOptions(
          accessLevel: StorageAccessLevel.guest,
        ),
      ).result;
      final slashIndex = key.indexOf("/");
      final objectFolder = key.substring(0, slashIndex + 1);
      final objectName = key.substring(slashIndex + 1);
      final encodedObjectName = Uri.encodeFull(objectName);
      final preSignedUrl = preSignedUrlResult.url.toString();
      final objectUrl = preSignedUrl.substring(
              0, preSignedUrl.indexOf(objectFolder) + objectFolder.length) +
          encodedObjectName;
      return objectUrl;
    } catch (e) {
      rethrow;
    }
  }
}
