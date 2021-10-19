import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/application/auth/auth_bloc.dart';
import 'package:optyma_app/presentation/core/player_navigation_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:optyma_app/application/users/user_bloc.dart';

class Verify extends StatelessWidget {
  
  final firebaseAuth = FirebaseAuth.instance;
  final fUser = FirebaseAuth.instance.currentUser;
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
                textScaleFactor: 2,
                ),
              ),
              Center(
                child: ElevatedButton(onPressed: (){
                  BlocProvider.of<UserBloc>(context).add(const UserEvent.loggedOut());
                  BlocProvider.of<AuthBloc>(context).add(const AuthEvent.loggedOut());},
                  child: const Text("Cerrar Sesión")),
              )
            ]
              
          ),
      );
  }

}