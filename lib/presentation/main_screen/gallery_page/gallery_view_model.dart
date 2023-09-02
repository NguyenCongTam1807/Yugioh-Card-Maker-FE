import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yugioh_card_creator/data/models/uploaded_yugioh_card.dart';
import 'package:yugioh_card_creator/presentation/base/base_view_model.dart';
import 'package:yugioh_card_creator/presentation/main_screen/card_creator_page/card_widget/yugioh_card_widget.dart';
import 'package:yugioh_card_creator/presentation/resources/config_values.dart';
import 'package:yugioh_card_creator/presentation/view_model_states/state_renderer.dart';

import '../../../data/models/view_state.dart';
import '../../../domain/usecase/fetch_gallery_use_case.dart';
import '../../../domain/usecase/fetch_page_use_case.dart';
import '../../resources/strings.dart';

class GalleryViewModel extends ChangeNotifier with BaseViewModel{
  //final FetchGalleryUseCase _fetchGalleryUseCase;
  final FetchPageUseCase _fetchPageUseCase;
  GalleryViewModel(this._fetchPageUseCase);

  final galleryDataStreamController = BehaviorSubject<List<UploadedYugiohCard>>();
  final pagingController = PagingController<int, UploadedYugiohCard>(firstPageKey: 0, invisibleItemsThreshold: ConfigValues.galleryCardPerRow);

  @override
  void init() {
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
  }

  @override
  void dispose() {
    galleryDataStreamController.close();
    pagingController.dispose();
    super.dispose();
  }

  // Future<void> fetchGallery() async {
  //   stateStreamController.add(const ViewState(ViewModelState.loading, message: Strings.loadingContent));
  //   (await _fetchGalleryUseCase.execute(Void)).fold((failure) {
  //     stateStreamController.add(const ViewState(ViewModelState.error, message: Strings.loadingContentFailed));
  //   }, (list) {
  //     galleryDataStreamController.sink.add(list);
  //     stateStreamController.add(const ViewState(ViewModelState.normal));
  //   });
  // }

  Future<void> fetchPage(int pageKey) async {
    (await _fetchPageUseCase.execute(pageKey)).fold((failure) => pagingController.error = failure, (list) {
      final isLastPage = list.length < ConfigValues.galleryPageSize;
      if (isLastPage) {
        pagingController.appendLastPage(list);
      } else {
        pagingController.appendPage(list, pageKey + 1);
      }
    });
  }
}