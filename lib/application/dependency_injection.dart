import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yugioh_card_creator/application/app_preferences.dart';
import 'package:yugioh_card_creator/data/data_source/local_data_source.dart';
import 'package:yugioh_card_creator/data/data_source/remote_data_source.dart';
import 'package:yugioh_card_creator/data/network/dio_factory.dart';
import 'package:yugioh_card_creator/data/network/network_info.dart';
import 'package:yugioh_card_creator/data/network/rest_client.dart';
import 'package:yugioh_card_creator/domain/repository/gallery_repository.dart';
import 'package:yugioh_card_creator/domain/repository/storage_repository.dart';
import 'package:yugioh_card_creator/domain/usecase/gallery_use_case.dart';
import 'package:yugioh_card_creator/domain/usecase/upload_card_use_case.dart';
import 'package:yugioh_card_creator/presentation/main_screen/main_screen_view_model.dart';
import 'package:yugioh_card_creator/presentation/settings_screen/settings_view_model.dart';

import '../data/network/rest_client_impl.dart';
import '../data/network/yugioh_api.dart';
import '../presentation/main_screen/card_creator_page/card_creator_view_model.dart';
import '../presentation/main_screen/gallery_page/gallery_view_model.dart';

final getIt = GetIt.I;

Future<void> initAppModule() async {
  final sharedPref = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() =>  sharedPref);
  getIt.registerLazySingleton<AppPreferences>(() =>  AppPreferences(getIt()));

  getIt.registerLazySingleton<DioFactory>(() => const DioFactory());
  final dio = getIt<DioFactory>().getDio();
  getIt.registerLazySingleton<RestClient>(() => RestClientImpl(dio, baseUrl: YugiohApi.baseUrl));

  getIt.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(getIt()));
  getIt.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(InternetConnectionChecker()));

  getIt.registerLazySingleton<GalleryRepository>(() => GalleryRepositoryImpl(getIt(), getIt(), getIt()));
  getIt.registerLazySingleton<FetchGalleryUseCase>(()=> FetchGalleryUseCase(getIt()));

  getIt.registerLazySingleton<StorageRepository>(()=> S3StorageRepository());
  getIt.registerLazySingleton<UploadCardUseCase>(()=> UploadCardUseCase(getIt(), getIt()));

  getIt.registerLazySingleton<ImagePicker>(() => ImagePicker());
  getIt.registerLazySingleton<MainScreenViewModel>(() => MainScreenViewModel());
  getIt.registerLazySingleton<GalleryViewModel>(() => GalleryViewModel(getIt()));
  getIt.registerLazySingleton<CardCreatorViewModel>(() => CardCreatorViewModel(getIt()));
  getIt.registerLazySingleton<SettingsViewModel>(() => SettingsViewModel(getIt()));
}