import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class DB {
  final db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> init() {
    return db.collection('CRUD').snapshots();
  }

  Future<String> createData(String name) async {
    DocumentReference ref = await db
        .collection('CRUD')
        .add({'name': '$name ', 'todo': randomTodo()});
    print(ref.id);
    return ref.id;
  }

  void readData(String id) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await db.collection('CRUD').doc(id).get();
    print(snapshot.data()['name']);
  }

  void updateData(DocumentSnapshot doc) async {
    await db.collection('CRUD').doc(doc.id).update({'todo': 'please 🤫'});
  }

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('CRUD').doc(doc.id).delete();
  }

  String randomTodo() {
    final randomNumber = Random().nextInt(4);
    String todo;
    switch (randomNumber) {
      case 1:
        todo = 'vokie';
        break;
      case 2:
        todo = 'Sett';
        break;
      case 3:
        todo = 'gg ez';
        break;
      default:
        todo = 'sheri enna';
        break;
    }
    return todo;
  }
}

DB db = DB();
