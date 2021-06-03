import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:optyma_app/models/plantilla_model.dart';



class PlantillasRepository{

  CollectionReference plantillasReference = FirebaseFirestore.instance.collection('plantillas');


  Future<void> addPlantilla( PlantillaModel plantilla ) async{
    plantillasReference.add({
      'difficulty'      : plantilla.difficulty,
      'expression'      : plantilla.expression,
      'sentence'        : plantilla.sentence,
      'subject'         : plantilla.subject,
      'timeOpen'        : plantilla.timeOpen,
      'timeClose'       : plantilla.timeClose,
      'timeStamp'       : Timestamp.now(),
      'uId'             : plantilla.uid,
    })
      .then((value) => print(value))
      .catchError((error)=> print("Failed to add plantilla: $error"));
  }
  Future<void> addPlantillaArit( PlantillaModel plantilla ) async{
    plantillasReference.add({
      'difficulty'      : plantilla.difficulty,
      'expression'      : plantilla.expression,
      'sentence'        : plantilla.sentence,
      'values'          : plantilla.values,
      'subject'         : plantilla.subject,
      'timeOpen'        : plantilla.timeOpen,
      'timeClose'       : plantilla.timeClose,
      'timeStamp'       : Timestamp.now(),
      'uId'             : plantilla.uid,
    })
      .then((value) => print(value))
      .catchError((error)=> print("Failed to add plantilla: $error"));
  }
  Stream<List<PlantillaModel>> getPlantillasArit(){
    return plantillasReference.where('subject', isEqualTo: 1)
    .snapshots().map((snapshot){
      return snapshot.docs.map((doc) => PlantillaModel.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<PlantillaModel>> getPlantillasAlge(){
    return plantillasReference.where('subject', isEqualTo: 2)
    .snapshots().map((snapshot){
      return snapshot.docs.map((doc) => PlantillaModel.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<PlantillaModel>> getPlantillasDife(){
    return plantillasReference.where('subject', isEqualTo: 3)
    .snapshots().map((snapshot){
      return snapshot.docs.map((doc) => PlantillaModel.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<PlantillaModel>> getPlantillasOpti(){
    return plantillasReference.where('subject', isEqualTo: 4)
    .snapshots().map((snapshot){
      return snapshot.docs.map((doc) => PlantillaModel.fromSnapshot(doc)).toList();
    });
  }

  Future<void> updatePlantilla(PlantillaModel plantilla) async {
    DocumentReference refPlantilla = plantillasReference.doc(plantilla.id);

    return await refPlantilla.update({
      'difficulty'      : plantilla.difficulty,
      'expression'      : plantilla.expression,
      'sentence'        : plantilla.sentence,
      'subject'         : plantilla.subject,
      'timeOpen'        : plantilla.timeOpen,
      'timeClose'       : plantilla.timeClose,
    });
  }

  Future<void> updatePlantillaArit(PlantillaModel plantilla) async {
    DocumentReference refPlantilla = plantillasReference.doc(plantilla.id);

    return await refPlantilla.update({
      'difficulty'      : plantilla.difficulty,
      'expression'      : plantilla.expression,
      'sentence'        : plantilla.sentence,
      'values'          : plantilla.values,
      'subject'         : plantilla.subject,
      'timeOpen'        : plantilla.timeOpen,
      'timeClose'       : plantilla.timeClose,
    });
  }

  Future<void> deletePlantilla(String id) async {
    DocumentReference refPlantilla = plantillasReference.doc(id);

    return await refPlantilla.delete();
  }
  Future <List<PlantillaModel>> getPlantillasByDifAndSubj({int subject, int difficulty}){
    
    return plantillasReference.
    where('subject', isEqualTo: subject ).
    where('difficulty', isLessThanOrEqualTo: difficulty).
    get().then((snap) => snap.docs.map((doc) => PlantillaModel.fromSnapshot(doc)).toList());
  }
}