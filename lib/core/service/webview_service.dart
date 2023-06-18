import 'package:badsound_counter_app/core/util/color_util.dart';
import 'package:badsound_counter_app/view/designsystem/theme/base_color.dart';
import 'package:get/get.dart';

import '../../view/feature/webview_screen/full_webview_screen.dart';

class WebViewService {
  static const String _baseUrl = 'https://bsc-webview.chuyong.kr';

  String get baseUrl => _baseUrl;

  void navigateToNotice() {
    navigateToPath('notice');
  }

  void navigateToPrivacy() {
    navigateToPath('privacy');
  }

  void navigateToPath(String path) {
    Get.to(() => FullWebViewScreen(
        '$_baseUrl/$path?bgColor=${ColorUtil.colorToHex(BaseColor.defaultBackgroundColor)}'));
  }
}
