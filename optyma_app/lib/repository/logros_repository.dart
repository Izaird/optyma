import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:optyma_app/models/logro_model.dart';

class LogrosRepository{

  CollectionReference logrosReference = FirebaseFirestore.instance.collection('logros');

  //Niveles
  Future<void> addLogroType1( LogroModel logro ) async{
    final result =
            await logrosReference.where('description',isEqualTo: logro.description).get();
    bool isempty = result.docs.isEmpty;
    if(!isempty){
      print("Description must be unique");
    }
    else{
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
    
  }

  //
  Future<void> addLogroType2( LogroModel logro ) async{
    final result =
            await logrosReference.where('description',isEqualTo: logro.description).get();
    bool isempty = result.docs.isEmpty;
    if(!isempty){
      print("Description must be unique");
    }
    else{
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
  }
  
  //Racha de dias 
  Future<void> addLogroType3( LogroModel logro ) async{
    final result =
            await logrosReference.where('description',isEqualTo: logro.description).get();
    bool isempty = result.docs.isEmpty;
    if(!isempty){
      print("Description must be unique");
    }
    else{
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
  }

  //Ejercicios realizados
  Future<void> addLogroType4( LogroModel logro ) async{
    final result =
            await logrosReference.where('description',isEqualTo: logro.description).get();
    bool isempty = result.docs.isEmpty;
    if(!isempty){
      print("Description must be unique");
    }
    else{
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
  }

  //Leaderboard
  Future<void> addLogroType5( LogroModel logro ) async{
    final result =
            await logrosReference.where('description',isEqualTo: logro.description).get();
    bool isempty = result.docs.isEmpty;
    if(!isempty){
      print("Description must be unique");
    }
    else{
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
  }


  Stream<List<LogroModel>> getLogrosNive(){
    return logrosReference.where('type', isEqualTo: 1)
    .snapshots().map((snapshot){
      return snapshot.docs.map((doc) => LogroModel.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<LogroModel>> getLogrosRres(){
    return logrosReference.where('type', isEqualTo: 2)
    .snapshots().map((snapshot){
      return snapshot.docs.map((doc) => LogroModel.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<LogroModel>> getLogrosRdia(){
    return logrosReference.where('type', isEqualTo: 3)
    .snapshots().map((snapshot){
      return snapshot.docs.map((doc) => LogroModel.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<LogroModel>> getLogrosEres(){
    return logrosReference.where('type', isEqualTo: 4)
    .snapshots().map((snapshot){
      return snapshot.docs.map((doc) => LogroModel.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<LogroModel>> getLogrosLead(){
    return logrosReference.where('type', isEqualTo: 5)
    .snapshots().map((snapshot){
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