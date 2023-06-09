import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:badsound_counter_app/presenter/feature/webview_screen/webview_screen_state.dart';
import 'package:badsound_counter_app/view/feature/webview_screen/full_webview_screen.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreenAction extends BaseAction<FullWebViewScreen, WebViewScreenAction, WebViewScreenState> {
  final String initialUrl;
  WebViewScreenAction(this.initialUrl): super(WebViewScreenState()) {
    webViewController.loadRequest(Uri.parse(initialUrl));
  }
  @override
  Future<WebViewScreenState> initState() async => WebViewScreenState();

  final webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (!request.url.startsWith('https://bsc-webview.bearus.co')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );

  void back() async {
    if(await webViewController.canGoBack()) {
      await webViewController.goBack();
    } else {
      Get.back();
    }
  }
}
