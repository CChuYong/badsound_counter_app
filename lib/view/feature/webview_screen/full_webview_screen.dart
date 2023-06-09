import 'package:badsound_counter_app/presenter/feature/webview_screen/webview_screen_state.dart';
import 'package:badsound_counter_app/presenter/feature/webview_screen/webview_screen_store.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/framework/base_view.dart';

class FullWebViewScreen extends BaseView<FullWebViewScreen, WebViewScreenAction, WebViewScreenState> {
  final String initialUrl;
  const FullWebViewScreen(this.initialUrl, {super.key});
  @override
  WebViewScreenAction initAction() => WebViewScreenAction(initialUrl);


  @override
  Widget render(BuildContext context, WebViewScreenAction action, WebViewScreenState state) {
    return WebViewWidget(
      controller: action.webViewController,
    );
  }

}