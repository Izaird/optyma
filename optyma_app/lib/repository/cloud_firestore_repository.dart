import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:optyma_app/models/logro_model.dart';
import 'package:optyma_app/models/user.dart';


class CloudFirestoreRepository{

  CollectionReference logros  = FirebaseFirestore.instance.collection('logros');
  CollectionReference users   = FirebaseFirestore.instance.collection('users');


  Future<void> addLogro( LogroModel logro ) async{
    logros.add({
      'nombre'      : logro.nombre,
      'descripcion'  : logro.descripcion 
    })
      .then((value) => print(value))
      .catchError((error)=> print("Faile to add user: $error"));

  }


  //
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

}