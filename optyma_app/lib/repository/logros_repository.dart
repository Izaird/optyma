import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:optyma_app/models/logro_model.dart';

class LogrosRepository{

  CollectionReference logrosReference = FirebaseFirestore.instance.collection('logros');

  //Niveles == type 1
  Future<void> addLogroNive( LogroModel logro ) async{
    final result = await logrosReference.where('description',isEqualTo: logro.description).get();
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

  //Racha de repuestas == type 2
  Future<void> addLogroRres( LogroModel logro ) async{
    final result =
            await logrosReference.where('description',isEqualTo: logro.description).get();
    bool isempty = result.docs.isEmpty;
    if(!isempty){
      print("Description must be unique");
    }
    else{
      logrosReference.add({
      'type'            : logro.type,
      'name'            : logro.name,
      'description'     : logro.description,
      'numberOfAnswers' : logro.numberOfAnswers,
    })
      .then((value) => print(value))
      .catchError((error)=> print("Failed to add logro: $error"));
    }
  }
  
  //Racha de dias == type 3
  Future<void> addLogroRdia( LogroModel logro ) async{
    final result =
            await logrosReference.where('description',isEqualTo: logro.description).get();
    bool isempty = result.docs.isEmpty;
    if(!isempty){
      print("Description must be unique");
    }
    else{
      logrosReference.add({
      'type'            : logro.type,
      'name'            : logro.name,
      'description'     : logro.description,
      'numberOfDays'    : logro.numberOfDays,
    })
      .then((value) => print(value))
      .catchError((error)=> print("Failed to add logro: $error"));
    }
  }

  //Ejercicios realizados == type 4
  Future<void> addLogroEres( LogroModel logro ) async{
    final result =
            await logrosReference.where('description',isEqualTo: logro.description).get();
    bool isempty = result.docs.isEmpty;
    if(!isempty){
      print("Description must be unique");
    }
    else{
      logrosReference.add({
      'type'              : logro.type,
      'name'              : logro.name,
      'description'       : logro.description,
      'numberOfExercises' : logro.numberOfExercises,
    })
      .then((value) => print(value))
      .catchError((error)=> print("Failed to add logro: $error"));
    }
  }

  //Leaderboard == type 5
  Future<void> addLogroLead( LogroModel logro ) async{
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

  Future<void> updateLogroNive(LogroModel logro) async {
    DocumentReference refLogro = logrosReference.doc(logro.id);

    final result = await logrosReference.where('description',isEqualTo: logro.description).get();
    bool isempty = result.docs.isEmpty;
    if(!isempty){
      print("Description must be unique");
    }
    else{
      return await refLogro.set({
        'type'        : logro.type,
        'name'        : logro.name,
        'description' : logro.description,
        'difficulty'  : logro.difficulty,
        'subject'     : logro.subject
      });

    }
  }

  Future<void> updateLogroRres(LogroModel logro) async {
    DocumentReference refLogro = logrosReference.doc(logro.id);

    final result = await logrosReference.where('description',isEqualTo: logro.description).get();
    bool isempty = result.docs.isEmpty;
    if(!isempty){
      print("Description must be unique");
    }
    else{
      return await refLogro.set({
        'type'            : logro.type,
        'name'            : logro.name,
        'description'     : logro.description,
        'numberOfAnswers' : logro.numberOfAnswers,
      });

    }
  }

  Future<void> updateLogroRdia(LogroModel logro) async {
    DocumentReference refLogro = logrosReference.doc(logro.id);

    final result = await logrosReference.where('description',isEqualTo: logro.description).get();
    bool isempty = result.docs.isEmpty;
    if(!isempty){
      print("Description must be unique");
    }
    else{
      return await refLogro.set({
        'type'            : logro.type,
        'name'            : logro.name,
        'description'     : logro.description,
        'numberOfDays'    : logro.numberOfDays
      });

    }
  }

  Future<void> updateLogroEres(LogroModel logro) async {
    DocumentReference refLogro = logrosReference.doc(logro.id);

    final result = await logrosReference.where('description',isEqualTo: logro.description).get();
    bool isempty = result.docs.isEmpty;
    if(!isempty){
      print("Description must be unique");
    }
    else{
      return await refLogro.set({
      'type'              : logro.type,
      'name'              : logro.name,
      'description'       : logro.description,
      'numberOfExercises' : logro.numberOfExercises
      });

    }
  }

  Future<void> updateLogroLead(LogroModel logro) async {
    DocumentReference refLogro = logrosReference.doc(logro.id);

    final result = await logrosReference.where('description',isEqualTo: logro.description).get();
    bool isempty = result.docs.isEmpty;
    if(!isempty){
      print("Description must be unique");
    }
    else{
      return await refLogro.set({
        'type'        : logro.type,
        'name'        : logro.name,
        'description' : logro.description,
        'subject'     : logro.subject
      });

    }
  }

  Future<void> deleteLogro(String id) async {
    DocumentReference refLogro = logrosReference.doc(id);

    return await refLogro.delete();
  }
}