import 'package:badsound_counter_app/core/util/extension.dart';
import 'package:badsound_counter_app/view/feature/navigator_screen/main_screen/main_screen.dart';

import '../../../core/framework/base_action.dart';
import '../../../core/framework/state_store.dart';
import '../../../core/repository/user_repository.dart';
import '../../../dependencies.config.dart';
import 'main_screen_stat_box_state.dart';

class MainScreenState {
  MainPageStatBoxState statBoxState;
  MainScreenState(this.statBoxState);
}

class MainScreenAction
    extends BaseAction<MainPage, MainScreenAction, MainScreenState> {
  MainScreenAction() : super(MainScreenState(StateStore.loadState(MainPageStatBoxState)
      ?.let(MainPageStatBoxState.fromJson) ??
      MainPageStatBoxState('...', '', '')));

  final UserRepository userRepository = inject<UserRepository>();

  @override
  Future<MainScreenState> initState() async {
    final statBox = await userRepository.getDashboard();
    return MainScreenState(statBox);
  }

  @override
  void dispose() {
    StateStore.saveState(MainPageStatBoxState, state.statBoxState.toJson());
  }
}
