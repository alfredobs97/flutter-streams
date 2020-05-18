import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class Chiste extends StatefulWidget {
  @override
  _ChisteState createState() => _ChisteState();
}

class _ChisteState extends State<Chiste> {
  final chisteController = StreamController<String>();

  int maxChistes = 10;

  generarChiste() async {
    if (maxChistes > 0) {
      final response = await http.get('https://sv443.net/jokeapi/v2/joke/Any?type=single');
      if (response.statusCode == 200) {
        final chistes = json.decode(response.body);
        chisteController.add(chistes["joke"]);
        maxChistes--;
        if (maxChistes == 0) chisteController.close();
      }
    }
  }

  // todo Stateful widget is only use to dispose Stream
  @override
  void dispose() {
    chisteController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Club de la comedia'),
      ),
      body: Center(
          child: StreamBuilder(
              stream: chisteController.stream,
              initialData: 'Comenzando ronda de chistes...',
              builder: (context, snapshot) {
                if (snapshot.data == '') return CircularProgressIndicator();
                if (snapshot.hasError) return Text('Tenemos problemas técnicos, ahora volvemos...');
                if (snapshot.connectionState == ConnectionState.waiting) return Text('Esperando');
                if (snapshot.connectionState == ConnectionState.done) return Text('Terminado');
                return AnimatedContainer(
                  duration: Duration(seconds: 1),
                  height: 100 + (2 * snapshot.data.toString().length.toDouble()),
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                  ),
                  child: Text(snapshot.data, style: TextStyle(fontSize: 20)),
                );
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          generarChiste();
        },
        tooltip: 'Pedir chiste',
        child: Icon(Icons.add),
      ),
    );
  }
}
