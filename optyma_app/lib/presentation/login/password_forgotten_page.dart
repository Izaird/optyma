import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/application/auth/auth_bloc.dart';
import 'package:optyma_app/application/auth/login_form/login_form_bloc.dart';
import 'package:optyma_app/application/users/user_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PasswordForgottenPage extends StatelessWidget{
  final firebaseAuth = FirebaseAuth.instance;
  final myController = TextEditingController();
  final snackBar = const SnackBar(
     content: Text("Se envio el correo para reestablecer contraseña"),
     duration: Duration(seconds: 15),
     backgroundColor: Colors.green,
  );
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contraseña olvidada'),
      ),
      body: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.email),
              labelText: 'Correo',
            ),
            autocorrect: false,
            controller: myController,
          ),
          TextButton(
            onPressed: () {
              firebaseAuth.sendPasswordResetEmail(email: myController.text);
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: const Text('Enviar correo'),
          )
        ],
        
      ),
    );
  }
}