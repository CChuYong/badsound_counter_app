import 'package:badsound_counter_app/core/framework/base_intent.dart';
import 'package:get/get.dart';

import 'main_screen_contract.dart';

class MainPageStatBoxStore extends GetxController {
  var isLoading = false.obs;

  updateLoading() {
    if(isLoading.isTrue) {
      isLoading = false.obs;
    } else {
      isLoading = true.obs;
    }
  }

  void processIntent(Intent intent) {
    switch (intent.runtimeType) {
      case ViewIntent:
        handleViewIntent(intent as ViewIntent);
        break;
    }
  }

  void handleViewIntent(ViewIntent intent) {

  }
}
