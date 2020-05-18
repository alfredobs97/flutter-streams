import 'dart:async';

import 'package:flutter/material.dart';

class Contador extends StatefulWidget {
  @override
  _ContadorState createState() => _ContadorState();
}

class _ContadorState extends State<Contador> {
  final _controller = TextEditingController();

  final _lengthStream = StreamController();

  _actualizarCaracteres() {
    _lengthStream.add(_controller.text.length);
  }

  // todo Stateful widget is only use to dispose Stream
  @override
  void dispose() {
    _lengthStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.addListener(_actualizarCaracteres);

    return Scaffold(
      appBar: AppBar(
        title: Text('Contador'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: TextFormField(
                controller: _controller,
                maxLines: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder()
                ),
              ),
            ),
          ),
          SizedBox(height: 50),
          StreamBuilder(initialData: 0,
          stream: _lengthStream.stream,
           builder: (context, snapshot) => Text('Número de caracteres ${snapshot.data}'))
        ],
      ),
    );
  }
}
