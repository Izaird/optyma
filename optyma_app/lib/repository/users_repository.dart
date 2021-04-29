import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:optyma_app/models/user.dart';


class UsersRepository{

  CollectionReference usersReference = FirebaseFirestore.instance.collection('users');

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

}