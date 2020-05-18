import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stream/model/developer.dart';
import 'package:stream/repository/firebase_repository.dart';

class Firebase extends StatelessWidget {
  final _firebase = FirebaseRepository();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Desarrolladores'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 320,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50),
                  Text('Introduce un RockStar'),
                  Column(children: <Widget>[
                    TextFormField(
                      controller: _nameController,
                      maxLines: 1,
                      decoration: InputDecoration(helperText: 'Nombre del Desarrollador'),
                    ),
                    SizedBox(height: 50),
                    TextFormField(
                      controller: _ageController,
                      maxLines: 1,
                      decoration: InputDecoration(helperText: 'Edad del Desarrollador'),
                    )
                  ]),
                  MaterialButton(
                      child: Text('Enviar', style: TextStyle(color: Colors.white)),
                      minWidth: 200,
                      color: Colors.deepPurpleAccent,
                      onPressed: () {
                        _firebase.saveDeveloper(Developer(_nameController.text, int.parse(_ageController.text)));
                      })
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: _firebase.getDevelopers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) return Text('Esperando datos');
                  if (snapshot.hasError) return Text('Intentelo de nuevo más tarde');
                  return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(snapshot.data.documents[index]['name']),
                          onDismissed: (_) {
                            _firebase.deleteDeveloper(snapshot.data.documents[index]['name']);
                          },
                          child: SizedBox(
                            height: 150,
                            child: Card(
                              color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text('Nombre: ${snapshot.data.documents[index]['name']}'),
                                  Text('Edad: ${snapshot.data.documents[index]['age']}'),
                                  FloatingActionButton(
                                    backgroundColor: Colors.amberAccent,
                                      child: Icon(Icons.add),
                                      onPressed: () {
                                        _firebase.addOneYearToDeveloper(snapshot.data.documents[index]['name']);
                                      })
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}