import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:flutter/cupertino.dart';

import '../../view/feature/navigator_screen/main_navigator.dart';

class MainNavigatorState {
  int pageNumber;
  bool incremental = false;

  MainNavigatorState({this.pageNumber = 1});
}

class MainNavigatorAction
    extends State<MainNavigator> {
  MainNavigatorAction();
  final MainNavigatorState state = MainNavigatorState();

  void bottomBarTap(int index) async {
    setState(() {
      state.incremental = index > state.pageNumber;
      state.pageNumber = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.render(context, this, state);
  }
}
