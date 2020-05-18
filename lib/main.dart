import 'package:flutter/material.dart';
import 'package:stream/pages/chiste.dart';
import 'package:stream/pages/contador.dart';
import 'package:stream/pages/firebase.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final _controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PageView(
          controller: _controller,
          children: <Widget>[
            Chiste(),
            Contador(),
            Firebase()
          ],
        ),
    );
  }
}
