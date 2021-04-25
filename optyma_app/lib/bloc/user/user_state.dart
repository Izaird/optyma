part of 'user_bloc.dart';

abstract class UserState extends Equatable{
  const UserState();

  @override
  List<Object> get props => [];
}

class UserUnitialized extends UserState{}

class UserInitialized extends UserState{
  //uId       : Google authentication Id
  //name      : User name
  //admin     : Is admin?
  final String uId;
  final String name;
  final String email;
  final bool admin;

  const UserInitialized({    
    this.uId, 
    this.name, 
    this.admin,
    this.email,
  });

  @override
  List<Object> get props => [uId ,name, email, admin];
}