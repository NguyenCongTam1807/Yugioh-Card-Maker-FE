import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yugioh_card_creator/data/models/uploaded_yugioh_card.dart';
import 'package:yugioh_card_creator/presentation/base/base_view_model.dart';
import 'package:yugioh_card_creator/presentation/view_model_states/state_renderer.dart';

import '../../../data/models/view_state.dart';
import '../../../domain/usecase/gallery_use_case.dart';
import '../../resources/strings.dart';

class GalleryViewModel extends ChangeNotifier with BaseViewModel{
  final FetchGalleryUseCase _fetchGalleryUseCase;
  GalleryViewModel(this._fetchGalleryUseCase);

  final galleryDataStreamController = BehaviorSubject<List<UploadedYugiohCard>>();

  @override
  void init() {
    fetchGallery();
  }

  @override
  void dispose() {
    galleryDataStreamController.close();
    super.dispose();
  }

  Future<void> fetchGallery() async {
    stateStreamController.add(const ViewState(ViewModelState.loading, message: Strings.loadingContent));
    (await _fetchGalleryUseCase.execute(Void)).fold((failure) {
      stateStreamController.add(const ViewState(ViewModelState.error, message: Strings.loadingContentFailed));
    }, (list) {
      galleryDataStreamController.sink.add(list);
      print("gallery fetched list: ${list.length}");
      stateStreamController.add(const ViewState(ViewModelState.normal));
    });
  }
}