import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stream/model/developer.dart';

class FirebaseRepository {
  final Firestore _firestore = Firestore.instance;

  Stream<QuerySnapshot> getDevelopers() {
    return _firestore.collection('developers').snapshots();
  }

  saveDeveloper(Developer developer){
    _firestore.collection('developers').add(developer.toMap());
  }

  deleteDeveloper(String name) async {
    final documents = await _firestore.collection('developers').where("name", isEqualTo: name).getDocuments();

    _firestore.collection('developers').document(documents.documents[0].documentID).delete();
  }

  addOneYearToDeveloper(String name) async{
    final documents = await _firestore.collection('developers').where("name", isEqualTo: name).getDocuments();

    int age = (await _firestore.collection('developers').document(documents.documents[0].documentID).get()).data['age'];

    _firestore.collection('developers').document(documents.documents[0].documentID).setData({'age': ++age}, merge: true);
  }
}
