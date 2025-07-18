

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../common_widgets/custom_app_bar.dart';

class NewsDetailScreen extends StatefulWidget {
  final String url;

  const NewsDetailScreen({Key? key, required this.url}) : super(key: key);
  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  late final WebViewController _controller;
  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Web View',automaticallyImplyLeading: true),
      body: WebViewWidget(controller: _controller),
    );
  }
}