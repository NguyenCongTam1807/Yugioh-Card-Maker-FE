import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:yugioh_card_creator/data/models/uploaded_yugioh_card.dart';
import 'package:yugioh_card_creator/presentation/main_screen/gallery_page/gallery_view_model.dart';

import '../../../application/dependency_injection.dart';
import '../../../data/models/view_state.dart';
import '../../common/common_functions.dart';
import '../../view_model_states/state_renderer.dart';

class GalleryView extends StatefulWidget with GetItStatefulWidgetMixin {
  GalleryView({Key? key}) : super(key: key);

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> with GetItStateMixin {
  final _galleryViewModel = getIt<GalleryViewModel>();

  @override
  void initState() {
    _galleryViewModel.init();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewState = watchStream(
            (GalleryViewModel vm) => vm.stateStreamController,
            const ViewState(ViewModelState.normal))
        .data??const ViewState(ViewModelState.normal);

    buildViewState(context, _galleryViewModel, viewState);

    return _normalContent();
  }

  Widget _normalContent() {
    final galleryData = watchStream(
        (GalleryViewModel vm) => vm.galleryDataStreamController,
        const <UploadedYugiohCard>[]);
    return galleryData.hasData
        ? GridView.builder(
            itemCount: galleryData.data!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (ctx, index) {
              final card = galleryData.data![index];
              return Text(
                  "${card.id} - ${card.uploadedAt}\n${card.yugiohCard?.creatorName}");
            },
          )
        : const Center(
            child: Text("No data"),
          );
  }
}
