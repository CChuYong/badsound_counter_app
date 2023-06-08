import 'package:badsound_counter_app/core/framework/base_action.dart';

import '../../view/feature/navigator_screen/main_navigator.dart';

class MainNavigatorState {
  int pageNumber;
  bool incremental = false;
  MainNavigatorState({this.pageNumber = 1});
}

class MainNavigatorAction extends BaseAction<MainNavigator, MainNavigatorAction, MainNavigatorState> {
  MainNavigatorAction() : super(MainNavigatorState());

  @override
  Future<MainNavigatorState> initState() async {
    return MainNavigatorState();
  }

  void bottomBarTap(int index) async{
    setState(() {
      state.incremental = index > state.pageNumber;
      state.pageNumber = index;
    });
  }

}