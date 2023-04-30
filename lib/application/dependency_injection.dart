import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yugioh_card_creator/presentation/card_creating_screen/card_creator_view_model.dart';

final getIt = GetIt.I;

void initAppModule() {
  getIt.registerLazySingleton<ImagePicker>(() => ImagePicker());
  getIt.registerLazySingleton<CardCreatorViewModel>(() => CardCreatorViewModel());
}