import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:optyma_app/models/logro_model.dart';
import 'package:optyma_app/models/logros/logro_type1_model.dart';
import 'package:optyma_app/models/logros/logro_type2_model.dart';
import 'package:optyma_app/models/logros/logro_type3_model.dart';
import 'package:optyma_app/models/logros/logro_type4_model.dart';
import 'package:optyma_app/models/logros/logro_type5_model.dart';

class LogrosRepository{

  CollectionReference logrosReference = FirebaseFirestore.instance.collection('logros');


  Future<void> addLogro( LogroModel logro ) async{
    logrosReference.add({
      'nombre'      : logro.name,
      'descripcion'  : logro.description 
    })
      .then((value) => print(value))
      .catchError((error)=> print("Failed to add logro: $error"));
  }

  Future<void> addLogroType1( LogroType1Model logro ) async{
    logrosReference.add({
      'nombre'      : logro.name,
      'descripcion' : logro.description,
      'difficulty'  : logro.difficulty,
      'subject'     : logro.subject
    })
      .then((value) => print(value))
      .catchError((error)=> print("Failed to add logro: $error"));
  }

Future<void> addLogroType2( LogroType2Model logro ) async{
    logrosReference.add({
      'nombre'      : logro.name,
      'descripcion' : logro.description,
      'data'        : logro.data
    })
      .then((value) => print(value))
      .catchError((error)=> print("Failed to add logro: $error"));
  }
  Future<void> addLogroType3( LogroType3Model logro ) async{
    logrosReference.add({
      'nombre'      : logro.name,
      'descripcion' : logro.description,
      'data'        : logro.data
    })
      .then((value) => print(value))
      .catchError((error)=> print("Failed to add logro: $error"));
  }
Future<void> addLogroType4( LogroType4Model logro ) async{
    logrosReference.add({
      'nombre'      : logro.name,
      'descripcion' : logro.description,
      'data'        : logro.data
    })
      .then((value) => print(value))
      .catchError((error)=> print("Failed to add logro: $error"));
  }

Future<void> addLogroType5( LogroType5Model logro ) async{
    logrosReference.add({
      'nombre'      : logro.name,
      'descripcion' : logro.description,
      'difficulty'  : logro.difficulty,
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