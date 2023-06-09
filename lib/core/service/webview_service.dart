import 'package:get/get.dart';

import '../../view/feature/webview_screen/full_webview_screen.dart';

class WebViewService {
  static const String _baseUrl = 'https://bsc-webview.bearus.co';

  String get baseUrl => _baseUrl;

  void navigateToNotice() {
    navigateToPath('notice');
  }

  void navigateToPrivacy() {
    navigateToPath('privacy');
  }

  void navigateToPath(String path) {
    Get.to(() => FullWebViewScreen('$_baseUrl/$path'));
  }
}