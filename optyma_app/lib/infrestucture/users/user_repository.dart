import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:optyma_app/domain/auth/i_auth_facade.dart';
import 'package:optyma_app/domain/core/errors.dart';
import 'package:optyma_app/domain/users/i_user_repository.dart';
import 'package:optyma_app/domain/users/user.dart';
import 'package:optyma_app/domain/users/user_failure.dart';
import 'package:optyma_app/infrestucture/core/firestore_helpers.dart';
import 'package:optyma_app/infrestucture/users/user_dtos.dart';
import 'package:optyma_app/injection.dart';
import 'package:rxdart/rxdart.dart';



@LazySingleton(as: IUserRepository)
class UserRepository implements IUserRepository{

  final FirebaseFirestore _firestore;
  UserRepository(this._firestore);


  @override
  Future<Either<UserFailure, Unit>> create(User user) async{
    try{
      final usersRef = await _firestore.userReference();
      final userDto =  UserDto.fromDomain(user);

      await usersRef.doc(user.id.getOrCrash()).set(userDto.toJson());

      return right(unit);

    } on FirebaseException catch(e){
      if(e.message!.contains('PERMISSION_DENIED')){
        return left(const UserFailure.insufficientPermission());
      } else{
        debugPrint(e.toString());
        return left(const UserFailure.unexpected());
      }
    }
  }

  @override
  Future<Either<UserFailure, Unit>> update(User user) async{
    try{
      final usersRef = await _firestore.userReference();
      final userDto =  UserDto.fromDomain(user);

      await usersRef.doc(user.id.getOrCrash()).update(userDto.toJson());

      return right(unit);

    } on FirebaseException catch(e){
      if(e.message!.contains('PERMISSION_DENIED')){
        return left(const UserFailure.insufficientPermission());
      } else if(e.message!.contains('NOT_FOUND')){
        return left(const UserFailure.unableToUpdate());
      }else{
        debugPrint(e.toString());
        return left(const UserFailure.unexpected());
      }
    }
  }

  @override
  Future<Either<UserFailure, Unit>> delete(User user) async{
    try{
      final usersRef = await _firestore.userReference();

      await usersRef.doc(user.id.getOrCrash()).delete();

      return right(unit);

    } on FirebaseException catch(e){
      if(e.message!.contains('PERMISSION_DENIED')){
        return left(const UserFailure.insufficientPermission());
      } else if(e.message!.contains('NOT_FOUND')){
        return left(const UserFailure.unableToUpdate());
      }else{
        debugPrint(e.toString());
        return left(const UserFailure.unexpected());
      }
    }
  }


  @override
  Future<Option<User>> getUser(String userId) async{
    final usersRef = await _firestore.userReference();
    final DocumentSnapshot userDoc = await usersRef.doc(userId).get();

    if(userDoc.exists){
      final User user = UserDto.fromFirestore(userDoc).toDomain();
      return some(user);
    }else{
      return none();
    }
  }

  @override
  Stream<Either<UserFailure, List<User>>> watchAll() async*{
    final userReference = await _firestore.userReference();
    final userIdOption = await getIt<IAuthFacade>().getSignedInUserId();
    final userId = userIdOption.getOrElse(() => throw NotAuthenticatedError());
    yield* userReference
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
          .map((doc) => UserDto.fromFirestore(doc).toDomain()),
      )
      .map(
        (users) => right<UserFailure, List<User>>(
          users
          .where((user) => user.id.getOrCrash() != userId.getOrCrash())
            .toList()
        )
      )
      .onErrorReturnWith(
        (e, s) {
          if (e is FirebaseException &&
              e.message!.contains('PERMISSION_DENIED')) {
            return left(const UserFailure.insufficientPermission());
          } else {
            debugPrint(e.toString());
            return left(const UserFailure.unexpected());
          }
        },
    );   
  }

  @override
  Stream<Either<UserFailure, List<User>>> watchAdmins() async*{
    final userReference = await _firestore.userReference();
    final userIdOption = await getIt<IAuthFacade>().getSignedInUserId();
    final userId = userIdOption.getOrElse(() => throw NotAuthenticatedError());
    yield* userReference
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
          .map((doc) => UserDto.fromFirestore(doc).toDomain()),
      )
      .map(
        (users) => right<UserFailure, List<User>>(
          users
          .where((user) => user.id.getOrCrash() != userId.getOrCrash())
          .where((user) => user.admin == true)
            .toList()
        )
      )
      .onErrorReturnWith(
        (e, s) {
          if (e is FirebaseException &&
              e.message!.contains('PERMISSION_DENIED')) {
            return left(const UserFailure.insufficientPermission());
          } else {
            debugPrint(e.toString());
            return left(const UserFailure.unexpected());
          }
        },
    );   
  }

  @override
  Stream<Either<UserFailure, List<User>>> watchPlayers() async*{
    final userDoc = await _firestore.userReference();
    final userIdOption = await getIt<IAuthFacade>().getSignedInUserId();
    final userId = userIdOption.getOrElse(() => throw NotAuthenticatedError());
    yield* userDoc
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
          .map((doc) => UserDto.fromFirestore(doc).toDomain()),
      )
      .map(
        (users) => right<UserFailure, List<User>>(
          users
          .where((user) => user.id.getOrCrash() != userId.getOrCrash())
          .where((user) => user.admin == false)
            .toList()
        )
      )
      .onErrorReturnWith(
        (e, s) {
          if (e is FirebaseException &&
              e.message!.contains('PERMISSION_DENIED')) {
            return left(const UserFailure.insufficientPermission());
          } else {
            debugPrint(e.toString());
            return left(const UserFailure.unexpected());
          }
        },
    );   
  }



}