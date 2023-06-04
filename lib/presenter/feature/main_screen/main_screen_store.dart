import 'package:badsound_counter_app/core/framework/base_intent.dart';
import 'package:get/get.dart';

import 'main_screen_contract.dart';

class MainScreenStore extends GetxController {
  var count = "abs".obs;
  var isLoading = false.obs;

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
