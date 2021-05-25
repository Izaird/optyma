import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:optyma_app/models/plantilla_model.dart';



class PlantillasRepository{

  CollectionReference plantillasReference = FirebaseFirestore.instance.collection('plantillas');


  Future<void> addPlantilla( PlantillaModel plantilla ) async{
    plantillasReference.add({
      'dificultad'      : plantilla.dificultad,
      'exp'             : plantilla.exp,
      'sentencia'       : plantilla.sentencia,
      'tema'            : plantilla.tema,
      'tiempoAbierta'   : plantilla.tiempoAbierta,
      'tiempoCerrada'   : plantilla.tiempoCerrada,
      'timeStamp'       : plantilla.timestamp,
      'uId'             : plantilla.uid,
    })
      .then((value) => print(value))
      .catchError((error)=> print("Failed to add plantilla: $error"));
  }

  Stream<List<PlantillaModel>> getPlantillas(){
    return plantillasReference.snapshots().map((snapshot){
      return snapshot.docs.map((doc) => PlantillaModel.fromSnapshot(doc)).toList();
    });
  }

  Future<void> updatePlantillaData(PlantillaModel plantilla) async {
    DocumentReference refPlantilla = plantillasReference.doc(plantilla.id);

    return await refPlantilla.update({
      'dificultad'      : plantilla.dificultad,
      'exp'             : plantilla.exp,
      'sentencia'       : plantilla.sentencia,
      'tema'            : plantilla.tema,
      'tiempoAbierta'   : plantilla.tiempoAbierta,
      'tiempoCerrada'   : plantilla.tiempoCerrada,
    });
  }

  Future<void> deletePlantilla(String id) async {
    DocumentReference refPlantilla = plantillasReference.doc(id);

    return await refPlantilla.delete();
  }
  getRandomPlantilla (String tema, int dif){
    print(FirebaseFirestore.instance.collection('plantillas').
    where('tema', isEqualTo: tema ).
    where('dificulttad', isLessThanOrEqualTo: dif).
    get());
    return FirebaseFirestore.instance.collection('plantillas').
    where('tema', isEqualTo: tema ).
    where('dificulttad', isLessThanOrEqualTo: dif).
    get();
  }
}