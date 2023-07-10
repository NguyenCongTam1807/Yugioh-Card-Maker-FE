import 'package:rxdart/rxdart.dart';

import '../view_model_states/state_renderer.dart';

abstract class BaseViewModel {
  final stateStreamController = BehaviorSubject<ViewModelState>();

  void init() {}

  void dispose() {
    stateStreamController.close();
  }
}