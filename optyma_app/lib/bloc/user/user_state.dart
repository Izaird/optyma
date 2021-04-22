part of 'user_bloc.dart';

abstract class UserState extends Equatable{
  const UserState();

  @override
  List<Object> get props => [];
}


class UserUnitialized extends UserState{}

class UserInitialized extends UserState{
  //uId       : Id con la que esta registrado en la base de datos
  //name      : Nombre de usuario
  //admin     : Es administrador?
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

  // @override
  // String toString() {
  //   // TODO: implement toString
  //   return '''UserState{ 
  //     uid   : $uId,
  //     name  : $name,
  //     admin : $admin,
  //     email : $email,
  //   }
       
  //   ''';
  // }


