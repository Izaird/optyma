import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/application/auth/login_form/login_form_bloc.dart';
import 'package:optyma_app/injection.dart';
import 'package:optyma_app/presentation/login/widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de sesión'),
      ),
      body: BlocProvider(
        create: (context) => getIt<LoginFormBloc>(),
        child: LoginForm(),
      ),
    );
  }
}