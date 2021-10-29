import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:optyma_app/domain/core/value_objects.dart';
import 'auth_failure.dart';
import 'value_objects.dart';

abstract class IAuthFacade{

  firebase.User? getFirebaseUser();

  Future<Option<UniqueId>> getSignedInUserId();

  //We cannot use void, so insted use Unit if you don't want to return 'anything'
  Future<Either<AuthFailure,Unit>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password
  });
  
  Future<Either<AuthFailure,Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password
  });

  Future<Either<AuthFailure, Unit>> sendPasswordResetEmail({
    required EmailAddress emailAddress
  });

  Future<Either<AuthFailure, Unit>> signInWithGoogle();

  Future<void> signOut();
}