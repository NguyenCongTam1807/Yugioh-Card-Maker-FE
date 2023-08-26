import 'package:rxdart/rxdart.dart';
import 'package:yugioh_card_creator/data/models/view_state.dart';

import '../view_model_states/state_renderer.dart';

abstract class BaseViewModel {
  final stateStreamController = BehaviorSubject<ViewState>();

  void init() {}

  void dispose() {
    stateStreamController.close();
  }
}