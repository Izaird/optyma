import 'package:dartz/dartz.dart';
import 'package:optyma_app/domain/users/user.dart';
import 'package:optyma_app/domain/users/user_failure.dart';

abstract class IUserRepository{
  Stream<Either<UserFailure,List<User>>> watchAll();
  Stream<Either<UserFailure,List<User>>> watchAdmins();
  Stream<Either<UserFailure,List<User>>> watchPlayers();
  Future<Either<UserFailure, Unit>> create(User user);
  Future<Either<UserFailure, Unit>> update(User user);
  Future<Either<UserFailure, Unit>> delete(User user);
  Future<bool> isAdmin(String userId);
}