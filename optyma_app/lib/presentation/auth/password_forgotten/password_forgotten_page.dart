import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/application/auth/password_forgotten_form/password_forgotten_form_bloc.dart';
import 'package:optyma_app/injection.dart';
import 'package:optyma_app/presentation/auth/password_forgotten/widgets/password_forgotten_form_widget.dart';


class PasswordForgottenPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar contraseña'),
      ),
      body: BlocProvider(
        create: (context) => getIt<PasswordForgottenFormBloc>(),
        child: PasswordForgottenForm(),
      ),
    );
  }
}