
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/application/auth/auth_bloc.dart';
import 'package:optyma_app/application/users/user_bloc.dart';

class Verify extends StatelessWidget {
  
  final firebaseAuth = FirebaseAuth.instance;
  final fUser = FirebaseAuth.instance.currentUser;
  final snackBar = const SnackBar(
     content: Text("Se reenvio el correo de confirmación"),
     duration: Duration(seconds: 15),
     backgroundColor: Colors.green,
   );
  @override
  Widget build(BuildContext context) { 

    return Scaffold(
        appBar: AppBar(
          title: const Text('Email no verificado'),
        ),
          body: Column(
            children: [
              Center(
                child: Text('Por favor verifica el correo ${fUser?.email} y vuelve a iniciar sesión',
                textScaleFactor: 1.75,
                ),
              ),
              
              Center(
                child: ElevatedButton(
                  onPressed: (){
                    fUser?.sendEmailVerification();
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                child: const Text("Reenviar"),
                ),
              ),

              Center(
                child: ElevatedButton(
                  onPressed: (){
                    BlocProvider.of<UserBloc>(context).add(const UserEvent.loggedOut());
                    BlocProvider.of<AuthBloc>(context).add(const AuthEvent.loggedOut());
                    },
                  child: const Text("Cerrar Sesión")),
              ), 
            ]
              
          ),
      );
  }

}