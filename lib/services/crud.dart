import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CrudMethods {
  Future<void> addData(noteData) async{
    FirebaseFirestore.instance.collection('notes').add(noteData).catchError((e) {

    });
  }

  getData() async{
    return await FirebaseFirestore.instance.collection('notes').get();
  }
}