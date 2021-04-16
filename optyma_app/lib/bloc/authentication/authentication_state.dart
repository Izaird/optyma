part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  
  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class Uninitialized extends AuthenticationState{
  @override
  String toString() => 'No inicializado';
}

class Success extends AuthenticationState {
 
  final String displayName;

  const Success(this.displayName);

  @override
  List<Object> get props => [displayName];

  @override
  String toString() => 'Autenticado - displayName :$displayName';
}

class Failure  extends AuthenticationState {
  @override
  String toString() => 'No autenticado';
}