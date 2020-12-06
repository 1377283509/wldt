import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class CultureDetailsPage extends StatefulWidget {
  final String url;
  final String title;
  CultureDetailsPage(this.title, this.url);
  @override
  _CultureDetailsPageState createState() => _CultureDetailsPageState();
}

class _CultureDetailsPageState extends State<CultureDetailsPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(),
      url: widget.url,
    );
  }
}
