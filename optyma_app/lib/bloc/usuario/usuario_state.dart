part of 'usuario_bloc.dart';

@immutable
class UsuarioState {

  final bool conectado;
  final bool esAdmin;
  final String userName;
  final String userMail;

  UsuarioState({    
    this.conectado = false, 
    this.esAdmin   = false, 
    this.userName ='',
    this.userMail ='',
    });

  UsuarioState copyWith({
  bool conectado,
  bool esAdmin,
  String userName,
  String userMail,
  }) => UsuarioState(
    conectado   : conectado   ?? this.conectado,
    esAdmin     : esAdmin     ?? this.esAdmin,
    userName    : userName    ?? this.userName,
    userMail    : userMail    ?? this.userMail,
  );

}
