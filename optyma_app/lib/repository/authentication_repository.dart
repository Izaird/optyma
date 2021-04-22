// Imports
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthenticationRepository{
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
 
  // Constructor  
  AuthenticationRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
    _googleSignIn   = googleSignIn ?? GoogleSignIn();


  // SignInWithGoogle
  Future<User> signInWithGoogle() async {

      final GoogleSignInAccount         googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication  googleAuth = await googleUser.authentication;
      final AuthCredential credential =  GoogleAuthProvider.credential(
        accessToken : googleAuth.accessToken,
        idToken     : googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
      return _firebaseAuth.currentUser;
    
  }

  // SigiINWithCredentials
  Future<void> signInWithCredentials({String email, String password}) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password
    );
  }

  // SignUp   -   Registro
  Future<void> signUp({String email, String password}) async{
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password
    );
  }

  // SignOut
  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut()
    ]);
  }

  // Esta logueado?
  bool isSignedIn(){
    final currentUser = _firebaseAuth.currentUser;
    
    return (currentUser != null);
  }


  // Obtener usuario
  User getUser() {
    return _firebaseAuth.currentUser;
  }
}

  
  
