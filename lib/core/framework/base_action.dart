import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view/designsystem/theme/base_icon.dart';
import '../util/debouncer.dart';
import 'base_view.dart';

enum SnackBarType { RED, GREEN, YELLOW, GREY }

abstract class BaseAction<V extends BaseView<V, A, S>,
A extends BaseAction<V, A, S>, S> extends GetxController {
  S state;

  BaseAction(this.state);

  bool isBusy = true; // must be started as true

  final Debouncer reloadDbn = Debouncer(const Duration(milliseconds: 300));
  final Debouncer renderDbn = Debouncer(const Duration(milliseconds: 50));

  Future<S> initState();

  Future reloadScreen() async {
    await reloadDbn.runLastFuture(() => onReady());
  }

  @protected
  void render() {
    if (state != null) renderDbn.runLastCall(() => update());
  }

  Future<bool> onWillPop() async => true;

  @override
  Future<void> onReady() async {
    if (!isBusy) {
      isBusy = true;
      render();
    }

    state = await initState();
    isBusy = false;

    render();
  }

  void dispose() {
    super.dispose();
  }

  void didChangeDependencies(BuildContext context) {
    // there sould be nothing here, only helper for mixin
  }

  void setState(VoidCallback fn) {
    fn();
    render();
  }

  void errorSnackBar({
    required String message,
    SnackBarType type = SnackBarType.GREY, // neutral
    EdgeInsets margin = const EdgeInsets.all(12),
    int msDuration = 2000,
    SnackPosition position = SnackPosition.TOP,
  }) {
    Get.snackbar(
      '',
      message,
      // backgroundColor: bgColor,
      // colorText: txtColor,
      icon: Icon(BaseIcon.snackBarError),
      titleText: Container(),
      duration: Duration(milliseconds: msDuration),
      margin: margin,
      snackPosition: position,
    );
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is A && o.state == state;
  }

  @override
  int get hashCode => state.hashCode;
}
