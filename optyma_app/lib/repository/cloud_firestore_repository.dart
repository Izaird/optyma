import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:optyma_app/models/logro_model.dart';
import 'package:optyma_app/models/plantilla_model.dart';
import 'package:optyma_app/models/user.dart';


class CloudFirestoreRepository{

  CollectionReference logrosReference      = FirebaseFirestore.instance.collection('logros');
  CollectionReference usersReference       = FirebaseFirestore.instance.collection('users');
  CollectionReference plantillasReference  = FirebaseFirestore.instance.collection('plantillas');


  //------------------------------------------>User<------------------------------------------------
  Future<void> updateUserData(User user) async { 
    DocumentReference refUser = usersReference.doc(user.uid);

    return await refUser.set({
      'admin'       : user.admin,
      'uId'         : user.uid,
      'name'        : user.name,
      'email'       : user.email,
      'lastSignIn'  : DateTime.now(),
    });
  }

  Future<String> getUserName(String userId) async{  
    DocumentReference refUser = usersReference.doc(userId);
    DocumentSnapshot doc = await refUser.get();

    if(doc.exists){
      return doc.data()['name'] ?? false;
    }
    else{
      return null;
    } 
  }


  Future<void> updateUserName(String name, String userId) async{  
    DocumentReference refUser = usersReference.doc(userId);

    return await refUser.set({
      'name'        : name
    }); 
  }


  Future<bool> isAdmin(userId) async{
    DocumentReference refUser = usersReference.doc(userId);
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


  //------------------------------------------>Plantillas<------------------------------------------
  Future addPlantilla(PlantillaModel plantilla) async{
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
}