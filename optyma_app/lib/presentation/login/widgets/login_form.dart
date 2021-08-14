import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/application/auth/auth_bloc.dart';
import 'package:optyma_app/application/auth/login_form/login_form_bloc.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginFormBloc, LoginFormState>(
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
              // AutoRouter.of(context).replace(const HomePageRoute());
              context.read<AuthBloc>().add(const AuthEvent.authCheckRequested());
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

              const Logo(),
              const SizedBox(height: 8),

              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Correo',
                ),
                autocorrect: false,
                onChanged: (value) => context.read<LoginFormBloc>()
                  .add(LoginFormEvent.emailChanged(value)),
                validator: (_) => BlocProvider.of<LoginFormBloc>(context)
                    .state.emailAddress.value.fold(
                      (f) => f.maybeMap(
                        invalidEmail: (_) => 'Correo invalido',
                        orElse: () => null,
                      ),
                      (_) => null,
                    ),
              ),
              const SizedBox(height:8),


              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'Contraseña',
                ),
                autocorrect: false,
                obscureText: true,
                onChanged: (value) => context.read<LoginFormBloc>()
                  .add(LoginFormEvent.passwordChanged(value)),
                validator: (_) => context.read<LoginFormBloc>()
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
                  context.read<LoginFormBloc>().add(
                    const LoginFormEvent.LoginWithEmailAndPasswordPressed(),
                  );
                },
                child: const Text('Ingresar'),
              ),
              const SizedBox(height: 8),


              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'sign-in');
                  // AutoRouter.of(context).pushNamed('sign-in-page');
                  // BlocProvider.of<LoginFormBloc>(context).add(
                  //       const LoginFormEvent
                  //           .registerWithEmailAndPasswordPressed(),
                  //     );
                },
                child: const Text('Registrarse'),
              ),

              ElevatedButton(
                onPressed: () {
                  context.read<LoginFormBloc>()
                    .add(const LoginFormEvent.LoginWithGooglePressed()
                  );
                },
                child: const Text(
                  'Ingresar con Google',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      '📝',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 130),
    );
  }
}