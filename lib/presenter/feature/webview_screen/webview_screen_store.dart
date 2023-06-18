import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:badsound_counter_app/presenter/feature/webview_screen/webview_screen_state.dart';
import 'package:badsound_counter_app/view/designsystem/theme/base_color.dart';
import 'package:badsound_counter_app/view/feature/webview_screen/full_webview_screen.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_javascript_bridge/webview_javascript_bridge.dart';

class WebViewScreenAction extends BaseAction<FullWebViewScreen,
    WebViewScreenAction, WebViewScreenState> {
  final String initialUrl;

  WebViewScreenAction(this.initialUrl) : super(WebViewScreenState()) {
    webViewController.loadRequest(Uri.parse(initialUrl));
  }

  @override
  Future<WebViewScreenState> initState() async {
    _bridge.updateWebViewController(webViewController);
    _bridge.addMessageHandler(ClosureMessageHandler(
      resolver: (message, controller) => message.action == "return",
      handler: (message, controller) {
        back();
        return null;
      },
    ));
    return WebViewScreenState();
  }

  late final _bridge = WebViewJavaScriptBridge();
  late final webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..addJavaScriptChannel(
      webviewJavaScriptBridgeChannel,
      onMessageReceived: _bridge.receiveMessage,
    )
    ..setBackgroundColor(BaseColor.defaultBackgroundColor)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (!request.url.startsWith('https://bsc-webview.chuyong.kr')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );

  void back() async {
    if (await webViewController.canGoBack()) {
      await webViewController.goBack();
    } else {
      Get.back();
    }
  }
}
