import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart'

class MapViewPage extends StatelessWidget {
  final String mapHtmlFile; // HTML 파일 경로를 받기 위한 변수

  MapViewPage({required this.mapHtmlFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map View'),
      ),
      // body: WebView(
      //   initialUrl: mapHtmlFile, 
      //   javascriptMode: JavascriptMode.unrestricted,
      // ),
    );
  }
}
