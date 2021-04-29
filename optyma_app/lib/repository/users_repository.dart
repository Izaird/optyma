import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:optyma_app/models/user_model.dart';


class UsersRepository{

  CollectionReference usersReference = FirebaseFirestore.instance.collection('users');


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

  Stream<List<UserModel>> getAdmins(String userId) {
    return usersReference
    .where('admin', isEqualTo: true)
    .where('uId', isNotEqualTo: userId)
    .snapshots().map((snapshot){
      return snapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList();
    });

  }


  Stream<List<UserModel>> getNotAdmins(String userId) {
    return usersReference
    .where('admin', isEqualTo: false)
    .where('uId', isNotEqualTo: userId)
    .snapshots().map((snapshot){
      return snapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList();
    });

  }


  Future<void> updateUserData(UserModel user) async { 
    DocumentReference refUser = usersReference.doc(user.uid);

    return await refUser.set({
      'admin'       : user.admin,
      'uId'         : user.uid,
      'name'        : user.name,
      'email'       : user.email,
      'lastSignIn'  : DateTime.now(),
    });
  }

  Future<void> updateUserAdminStatus({String userId, bool admin}) async{
    DocumentReference refUser = usersReference.doc(userId);

    return await refUser.update({
      'admin'       : admin 
    });
  }

  Future<void> updateUserName(String name, String userId) async{  
    DocumentReference refUser = usersReference.doc(userId);

    return await refUser.set({
      'name'        : name
    }); 
  }



}