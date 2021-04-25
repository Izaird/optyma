part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserLoggedIn extends UserEvent{}


class UserSignedUp extends UserEvent{
  //User's name
  final String name;
  UserSignedUp(this.name);

  @override
  List<Object> get props => [name];
}

class UserLoggedOut extends UserEvent{}
