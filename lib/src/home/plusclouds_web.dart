import 'package:flutter/material.dart';
import 'package:plusclouds/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PluscloudsWeb extends StatelessWidget {
  const PluscloudsWeb({super.key});

  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (url) {},
        onProgress: (progress) {},
        onWebResourceError: (error) {
          debugPrint("WebView Hata: ${error.description}");
        },
      ));
    controller.loadHtmlString(webHtml);
    return WebViewWidget(controller: controller);
  }
}
