import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:optyma_app/models/logro_model.dart';

class LogrosRepository{

  CollectionReference logrosReference = FirebaseFirestore.instance.collection('logros');

  //Niveles
  Future<void> addLogroType1( LogroModel logro ) async{
    logrosReference.add({
      'type'        : logro.type,
      'name'        : logro.name,
      'description' : logro.description,
      'difficulty'  : logro.difficulty,
      'subject'     : logro.subject
    })
      .then((value) => print(value))
      .catchError((error)=> print("Failed to add logro: $error"));
  }

  //
  Future<void> addLogroType2( LogroModel logro ) async{
    logrosReference.add({
      'type'            : logro.type,
      'name'            : logro.name,
      'description'     : logro.description,
      'numberOfAnswers' : logro.numberOfAnswers,
    })
      .then((value) => print(value))
      .catchError((error)=> print("Failed to add logro: $error"));
  }
  
  //Racha de dias 
  Future<void> addLogroType3( LogroModel logro ) async{
    logrosReference.add({
      'type'            : logro.type,
      'name'            : logro.name,
      'description'     : logro.description,
      'numberOfDays'    : logro.numberOfDays,
    })
      .then((value) => print(value))
      .catchError((error)=> print("Failed to add logro: $error"));
  }

  //Ejercicios realizados
  Future<void> addLogroType4( LogroModel logro ) async{
    logrosReference.add({
      'type'              : logro.type,
      'name'              : logro.name,
      'description'       : logro.description,
      'numberOfExercises' : logro.numberOfExercises,
    })
      .then((value) => print(value))
      .catchError((error)=> print("Failed to add logro: $error"));
  }

  //Leaderboard
  Future<void> addLogroType5( LogroModel logro ) async{
    logrosReference.add({
      'type'        : logro.type,
      'nombre'      : logro.name,
      'descripcion' : logro.description,
      'subject'     : logro.subject
    })
      .then((value) => print(value))
      .catchError((error)=> print("Failed to add logro: $error"));
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