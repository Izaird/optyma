import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:optyma_app/models/logro_model.dart';
import 'package:optyma_app/models/plantilla_model.dart';
import 'package:optyma_app/models/user.dart';


class CloudFirestoreRepository{

  CollectionReference logros      = FirebaseFirestore.instance.collection('logros');
  CollectionReference users       = FirebaseFirestore.instance.collection('users');
  CollectionReference plantillas  = FirebaseFirestore.instance.collection('plantillas');


  //------------------------------------------>User<------------------------------------------------
  Future<void> updateUserData(User user) async { 
    DocumentReference refUser = users.doc(user.uid);

    return await refUser.set({
      'admin'       : user.admin,
      'uId'         : user.uid,
      'name'        : user.name,
      'email'       : user.email,
      'lastSignIn'  : DateTime.now(),
    });
  }

  Future<String> getUserName(String userId) async{  
    DocumentReference refUser = users.doc(userId);
    DocumentSnapshot doc = await refUser.get();

    if(doc.exists){
      return doc.data()['name'] ?? false;
    }
    else{
      return null;
    } 
  }


  Future<void> updateUserName(String name, String userId) async{  
    DocumentReference refUser = users.doc(userId);

    return await refUser.set({
      'name'        : name
    }); 
  }


  Future<bool> isAdmin(userId) async{
    DocumentReference refUser = users.doc(userId);
    DocumentSnapshot doc = await refUser.get();

    if(doc.exists){
      return doc.data()['admin'] ?? false;
    }
    else{
      return false;
    }
  }

  //------------------------------------------>Logros<----------------------------------------------
  Future<void> addLogro( LogroModel logro ) async{
    logros.add({
      'nombre'      : logro.name,
      'descripcion'  : logro.description 
    })
      .then((value) => print(value))
      .catchError((error)=> print("Faile to add user: $error"));
  }

  Future<void> updateLogroData(LogroModel logro) async {
    DocumentReference refLogro = logros.doc(logro.id);

    return await refLogro.set({
      'name'          : logro.name,
      'description'   : logro.description,
      'id'            : logro.id,
    });
  }

  Future<void> deleteLogroData(String id) async {
    DocumentReference refLogro = logros.doc(id);

    return await refLogro.delete();
  }

  //------------------------------------------>Plantillas<------------------------------------------
  Future addPlantilla(PlantillaModel plantilla) async{
    plantillas.add({
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
}