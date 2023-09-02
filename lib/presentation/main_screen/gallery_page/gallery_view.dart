import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:yugioh_card_creator/data/models/uploaded_yugioh_card.dart';
import 'package:yugioh_card_creator/presentation/main_screen/gallery_page/gallery_view_model.dart';
import 'package:yugioh_card_creator/presentation/resources/styles.dart';

import '../../../application/dependency_injection.dart';
import '../../../data/models/view_state.dart';
import '../../common/common_functions.dart';
import '../../resources/strings.dart';
import '../../view_model_states/state_renderer.dart';
import 'gallery_card_widget.dart';

class GalleryView extends StatefulWidget with GetItStatefulWidgetMixin {
  GalleryView({Key? key}) : super(key: key);

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> with GetItStateMixin {
  final _galleryViewModel = getIt<GalleryViewModel>();

  final _pagingController = getIt<GalleryViewModel>().pagingController;
  var currentState = ViewModelState.normal;
  // @override
  // Widget build(BuildContext context) =>
  //     // Don't worry about displaying progress or error indicators on screen; the
  // // package takes care of that. If you want to customize them, use the
  // // [PagedChildBuilderDelegate] properties.
  // PagedListView<int, BeerSummary>(
  //   pagingController: _pagingController,
  //   builderDelegate: PagedChildBuilderDelegate<BeerSummary>(
  //     itemBuilder: (context, item, index) => BeerListItem(
  //       beer: item,
  //     ),
  //   ),
  // );
  //

  @override
  void initState() {
    _galleryViewModel.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewState = watchStream(
                (GalleryViewModel vm) => vm.stateStreamController,
                const ViewState(ViewModelState.normal))
            .data ??
        const ViewState(ViewModelState.normal);

    if (viewState.state != currentState) {
      buildViewState(context, _galleryViewModel, viewState);
    }

    currentState = viewState.state;

    return _normalContent();
  }

  Widget _normalContent() {
    // final galleryData = watchStream(
    //     (GalleryViewModel vm) => vm.galleryDataStreamController,
    //     const <UploadedYugiohCard>[]);
    const space = 8.0;
    // return galleryData.hasData
    //     ? GridView.builder(
    //         itemCount: galleryData.data!.length,
    //         padding: const EdgeInsets.all(space),
    //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //           mainAxisSpacing: space,
    //             crossAxisSpacing: space,
    //             crossAxisCount: 2),
    //         itemBuilder: (ctx, index) {
    //           final card = galleryData.data![index];
    //           return GalleryCardWidget(card);
    //         },
    //       )
    //     : const Center(
    //         child: Text("No data"),
    //       );
    return RefreshIndicator(
      onRefresh: () => Future.sync(
        () => _pagingController.refresh(),
      ),
      child: PagedGridView<int, UploadedYugiohCard>(
        pagingController: _galleryViewModel.pagingController,
        padding: const EdgeInsets.all(space),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: space, crossAxisSpacing: space, crossAxisCount: 2),
        builderDelegate: PagedChildBuilderDelegate<UploadedYugiohCard>(
          itemBuilder: (context, card, index) {
            return GalleryCardWidget(card);
          },
          firstPageErrorIndicatorBuilder: (ctx) {
            return Column(
              children: [
                Text(
                  Strings.loadingContentFailed,
                  textAlign: TextAlign.center,
                  style: kCardNameTextStyle,
                ),
                ElevatedButton(
                    onPressed: () => _pagingController.retryLastFailedRequest(),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [Icon(Icons.refresh), SizedBox(width: 10,),Text(Strings.tryAgain)],
                    ))
              ],
            );
          },
        ),
      ),
    );
  }
}
