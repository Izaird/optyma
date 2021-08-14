import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/application/auth/auth_bloc.dart';
import 'package:optyma_app/application/auth/sign_in_form/sign_in_form_bloc.dart';

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
          () {},
          (either) => either.fold(
            (failure) {
              final snackBar = SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(failure.map(
                  cancelledByUser: (_) => 'Cancelado',
                  serverError: (_) => 'Error del servidor',
                  emailAlreadyInUse: (_) => 'Correo ya registrado',
                  invalidEmailAndPasswordCombination: (_) =>
                      'Combinancion invalida de correo y contraseña',
                )),
                // action: SnackBarAction(  
                //   label: 'Action',
                //   onPressed: (){},
                // ),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            (_) {
              BlocProvider.of<AuthBloc>(context).add(const AuthEvent.authCheckRequested());
            },
          ),
        );
      },
      builder: (context, state) {
        return Form(
          autovalidateMode: state.showErrorMessages ? AutovalidateMode.always : AutovalidateMode.disabled,
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: [
              const Text(
                '📝',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 130),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Correo',
                ),
                autocorrect: false,
                onChanged: (value) => BlocProvider.of<SignInFormBloc>(context)
                  .add(SignInFormEvent.emailChanged(value)),
                validator: (_) => BlocProvider.of<SignInFormBloc>(context)
                    .state
                    .emailAddress
                    .value
                    .fold(
                      (f) => f.maybeMap(
                        invalidEmail: (_) => 'Correo invalido',
                        orElse: () => null,
                      ),
                      (_) => null,
                    ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'Contraseña',
                ),
                autocorrect: false,
                obscureText: true,
                onChanged: (value) => BlocProvider.of<SignInFormBloc>(context)
                  .add(SignInFormEvent.passwordChanged(value)),
                validator: (_) => BlocProvider.of<SignInFormBloc>(context)
                  .state.password.value.fold(
                    (f) => f.maybeMap(
                      shortPassword: (_) => 'Contraseña invalida',
                      orElse: () => null,
                    ),
                    (_) => null,
                  ),
              ),
              const SizedBox(height: 8),
              TextButton(
               onPressed: () {
                 BlocProvider.of<SignInFormBloc>(context).add(
                       const SignInFormEvent
                           .registerWithEmailAndPasswordPressed(),
                     );
               },
               child: const Text('Registrarse'),
                ),

              if(state.isSubmitting)...[
                const SizedBox(height: 8),
                const LinearProgressIndicator(),  
              ],
            ],
          ),
        );
      },
    );
  }
}