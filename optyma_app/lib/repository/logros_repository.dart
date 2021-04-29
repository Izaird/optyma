import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:optyma_app/models/logro_model.dart';


class LogrosRepository{

  CollectionReference logrosReference = FirebaseFirestore.instance.collection('logros');


  Future<void> addLogro( LogroModel logro ) async{
    logrosReference.add({
      'nombre'      : logro.name,
      'descripcion'  : logro.description 
    })
      .then((value) => print(value))
      .catchError((error)=> print("Faile to add user: $error"));
  }

  Stream<List<LogroModel>> getLogros(){
    return logrosReference.snapshots().map((snapshot){
      return snapshot.docs.map((doc) => LogroModel.fromSnapshot(doc)).toList();
    });
  }

  Future<void> updateLogroData(LogroModel logro) async {
    DocumentReference refLogro = logrosReference.doc(logro.id);

    return await refLogro.set({
      'nombre'          : logro.name,
      'descripcion'   : logro.description,
    });
  }

  Future<void> deleteLogro(String id) async {
    DocumentReference refLogro = logrosReference.doc(id);

    return await refLogro.delete();
  }
}