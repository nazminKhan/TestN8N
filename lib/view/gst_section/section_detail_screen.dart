import 'package:flutter/material.dart';

import 'package:mvvm_demo/utils/app_color.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:share_plus/share_plus.dart';
import '../../common_widgets/custom_app_bar.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html_parser;
class SectionDetailScreen extends StatelessWidget {
  final String title;
  final String details;

  const SectionDetailScreen({Key? key, required this.title, required this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: title,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              _shareContent(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Html(
          data: details.replaceAll(" (i)", "<br><br>(i)").replaceAll(" (ii)", "<br><br>(ii)"),
        ),
      ),
    );
  }

  void _shareContent(BuildContext context) {
    final String plainText = _parseHtmlString(details);
    final String content = "$title\n$plainText";
    Share.share(content, subject: 'Look what I made!');
  }

  String _parseHtmlString(String htmlString) {
    final dom.Document document = html_parser.parse(htmlString);
    return document.body?.text ?? '';
  }
}