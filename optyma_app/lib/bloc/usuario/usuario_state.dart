part of 'usuario_bloc.dart';

@immutable
class UsuarioState {

  final bool conectado;
  final bool esAdmin;
  final String userName;

  UsuarioState({    
    this.conectado = false, 
    this.esAdmin   = false, 
    this.userName
    });

  UsuarioState copyWith({
  bool conectado,
  bool esAdmin,
  String userName,
  }) => UsuarioState(
    conectado   : conectado   ?? this.conectado,
    esAdmin     : esAdmin     ?? this.esAdmin,
    userName    : userName    ?? this.userName,
  );

}
