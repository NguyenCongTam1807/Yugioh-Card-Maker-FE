import '../../presentation/view_model_states/state_renderer.dart';

class ViewState {
  final ViewModelState state;
  final String? message;

  const ViewState(this.state, {this.message});
}