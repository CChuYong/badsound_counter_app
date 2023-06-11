import 'package:badsound_counter_app/core/framework/state_store.dart';
import 'package:badsound_counter_app/core/repository/user_repository.dart';
import 'package:badsound_counter_app/core/util/extension.dart';
import 'package:badsound_counter_app/dependencies.config.dart';
import 'package:badsound_counter_app/view/feature/navigator_screen/main_screen/main_screen_stat_box.dart';

import '../../../core/framework/base_action.dart';
import 'main_screen_stat_box_state.dart';

class MainPageStatBoxAction extends BaseAction<MainPageStatBox,
    MainPageStatBoxAction, MainPageStatBoxState> {
  final UserRepository userRepository = inject<UserRepository>();

  MainPageStatBoxAction()
      : super(StateStore.loadState(MainPageStatBoxState)
                ?.let(MainPageStatBoxState.fromJson) ??
            MainPageStatBoxState('...', '', ''));

  @override
  void dispose() {
    StateStore.saveState(MainPageStatBoxState, state.toJson());
  }

  @override
  Future<MainPageStatBoxState> initState() async {
    return await userRepository.getDashboard();
  }
}
