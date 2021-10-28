import 'package:cloud_firestore/cloud_firestore.dart';

extension FirestoreX on FirebaseFirestore{
  Future<CollectionReference> userReference() async{
    return FirebaseFirestore.instance
      .collection('users');
  }
}