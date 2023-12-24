import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
   static String? url;

  // WebViewScreen(this.url);
  WebViewController Controller=WebViewController()
  ..setJavaScriptMode(JavaScriptMode.disabled)
  ..loadHtmlString(url!);

  WebViewScreen(article);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body:
      //const WebView(
      //  initialUrl: url,
     // ),
      WebViewWidget(
        controller: Controller,

      ),
    );
  }
}
