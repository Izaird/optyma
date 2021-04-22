import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:optyma_app/models/plantilla_model.dart';



class PlantillasRepository{

  CollectionReference plantillas = FirebaseFirestore.instance.collection('plantillas');


  Future<bool> createPlantilla( PlantillaModel plantilla) async{
    return true;
  }


}