import 'package:dartz/dartz.dart';
import 'package:yugioh_card_creator/data/data_source/local_data_source.dart';
import 'package:yugioh_card_creator/data/models/uploaded_yugioh_card.dart';
import 'package:yugioh_card_creator/data/models/yugioh_card.dart';
import 'package:yugioh_card_creator/data/network/error_handler.dart';
import 'package:yugioh_card_creator/data/network/network_info.dart';

import '../../data/data_source/remote_data_source.dart';
import '../../data/network/failure.dart';
import '../../presentation/resources/strings.dart';

abstract class GalleryRepository {
  Future<Either<Failure, List<UploadedYugiohCard>>> fetchGallery();
  Future<Either<Failure, List<UploadedYugiohCard>>> fetchPage(int page);
  Future<Either<Failure, int>> uploadCard(YugiohCard yugiohCard);
}

class GalleryRepositoryImpl implements GalleryRepository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  final LocalDataSource _localDataSource;
  GalleryRepositoryImpl(this._remoteDataSource, this._networkInfo, this._localDataSource);

  @override
  Future<Either<Failure, List<UploadedYugiohCard>>> fetchGallery() async {
    try {
      if (await _networkInfo.isConnected()) {
        return Right(await _remoteDataSource.fetchGallery());
      } else {
        return Left(DataSourceStatus.connectionError.getFailure());
      }
    } on Exception catch (ex) {
      return Left(ex.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<UploadedYugiohCard>>> fetchPage(int page) async {
    try {
      if (await _networkInfo.isConnected()) {
        return Right(await _remoteDataSource.fetchPage(page));
      } else {
        return Left(DataSourceStatus.connectionError.getFailure());
      }
    } on Exception catch (ex) {
      return Left(ex.getFailure());
    }
  }

  @override
  Future<Either<Failure, int>> uploadCard(YugiohCard yugiohCard) async {
    try {
      if (await _networkInfo.isConnected()) {
        final response = await _remoteDataSource.uploadCard(yugiohCard);
        if (response/100 == 2) {
          return Right(response);
        } else {
          return const Left(Failure(Strings.uploadFailed));
        }
      } else {
        return Left(DataSourceStatus.connectionError.getFailure());
      }
    } on Exception catch (ex) {
      return Left(ex.getFailure());
    }
  }
}