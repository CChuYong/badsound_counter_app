import 'package:badsound_counter_app/view/feature/navigator_screen/main_screen/main_screen.dart';

import '../../../core/framework/base_action.dart';

class MainScreenState {}

class MainScreenAction
    extends BaseAction<MainPage, MainScreenAction, MainScreenState> {
  MainScreenAction() : super(MainScreenState());

  @override
  Future<MainScreenState> initState() async {
    return MainScreenState();
  }
}
