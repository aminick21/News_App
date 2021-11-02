import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class DisplayWebView extends StatefulWidget {
  final String url;

  const DisplayWebView({required this.url});

  @override
  _DisplayWebViewState createState() => _DisplayWebViewState();
}

class _DisplayWebViewState extends State<DisplayWebView> {
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform= SurfaceAndroidWebView();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebView(
        initialUrl: widget.url,
      ),
    );
  }
}
