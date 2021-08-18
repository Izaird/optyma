import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';


//This module allow to use injectable with a third-party
//package such as FirebaseAuth y GoogleSignIn
@module
abstract class FirebaseInjectableModule {
  @lazySingleton
  GoogleSignIn get googleSignIn => GoogleSignIn();
  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
  // @lazySingleton
  // Firestore get firestore => Firestore.instance;
}