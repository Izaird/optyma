part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  
  @override
  List<Object> get props => [];
}


class AuthenticationUninitialized extends AuthenticationState{
  @override
  String toString() => 'No inicializado';
}

class AuthenticationSuccess extends AuthenticationState {
 
  final String displayName;

  const AuthenticationSuccess(this.displayName);

  @override
  List<Object> get props => [displayName];

  @override
  String toString() => 'Autenticado - displayName :$displayName';
}

class AuthenticationFailure  extends AuthenticationState {
  @override
  String toString() => 'No autenticado';
}