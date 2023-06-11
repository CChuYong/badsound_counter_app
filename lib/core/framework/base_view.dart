import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'base_action.dart';

abstract class BaseView<V extends BaseView<V, A, S>,
    A extends BaseAction<V, A, S>, S> extends StatelessWidget {
  const BaseView({super.key});

  A initAction();

  @override
  Widget build(BuildContext context) {
    A action = initAction();
    return GetBuilder<A>(
      init: action,
      dispose: (State state) => action.dispose(),
      didChangeDependencies: (State state) => action.didChangeDependencies(
        state.context,
      ),
      builder: (A action) => WillPopScope(
        child: render(context, action, action.state),
        onWillPop: () => action.onWillPop(),
      ),
    );
  }

  Widget render(BuildContext context, A action, S state);
}
