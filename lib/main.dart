import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import './pages/papers.dart';
import './pages/stories.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Webview Example',
      theme: ThemeData.dark(),
      routes: {
        "/": (_) => Papers(),
        "/webview": (_) => WebviewScaffold(
              url: story.url,
              appBar: AppBar(
                title: Text(story.title),
                backgroundColor: Colors.deepPurple,
              ),
              withJavascript: true,
              withLocalStorage: true,
              withZoom: true,
            )
      },

      // home: Home(),
    );
  }
}