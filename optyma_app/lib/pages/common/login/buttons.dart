import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:optyma_app/cubit/login/login_cubit.dart';


class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton.icon(
      label: const Text(
        'Iniciar sesión con Google',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        primary: theme.accentColor,
      ),
      icon: const Icon(FontAwesomeIcons.google, color: Colors.white ,),
      onPressed: () => BlocProvider.of<LoginCubit>(context).logInWithGoogle(),
    );
  }
}


class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);


    return Row(

      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('¿No tienes una cuenta?'),

        TextButton(
          child: Text(
            'Regístrate',
            style: TextStyle(color: theme.primaryColor),
          ),

          onPressed: () => Navigator.pushNamed(context, 'signup'),
        )
      ]
    );
  }
}