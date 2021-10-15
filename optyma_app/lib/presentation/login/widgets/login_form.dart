import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/application/auth/auth_bloc.dart';
import 'package:optyma_app/application/auth/login_form/login_form_bloc.dart';
import 'package:optyma_app/application/users/user_bloc.dart';

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
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            (_) {
              // BlocProvider.of<UserBloc>(context).add(const UserEvent.loggedIn());
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

              const Logo(),
              const SizedBox(height: 8),

              const EmailField(),
              const SizedBox(height:8),


              const PasswordField(),
              const SizedBox(height: 8),

              const LogInButton(),
              const SizedBox(height: 8),

              const SignInButton(),

              const LoginWithGoogleButton(),

              if(BlocProvider.of<LoginFormBloc>(context).state.isSubmitting)...[
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

class LogInButton extends StatelessWidget {
  const LogInButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return     TextButton(
    
          onPressed: () {
    
            BlocProvider.of<LoginFormBloc>(context).add(
    
              const LoginFormEvent.loginWithEmailAndPasswordPressed(),
    
            );
    
          },
    
          child: const Text('Ingresar'),
    
        );
  }
}

class SignInButton extends StatelessWidget {
  const SignInButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, 'sign-in');
      },
      child: const Text('Registrarse'),
    );
  }
}

class LoginWithGoogleButton extends StatelessWidget {
  const LoginWithGoogleButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        BlocProvider.of<LoginFormBloc>(context)
          .add(const LoginFormEvent.loginWithGooglePressed()
        );
      },
      child: const Text(
        'Ingresar con Google',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.lock),
        labelText: 'Contraseña',
      ),
      autocorrect: false,
      obscureText: true,

      onChanged: (value) => BlocProvider.of<LoginFormBloc>(context)
        .add(LoginFormEvent.passwordChanged(value)),

      validator: (_) => context.read<LoginFormBloc>()
        .state.password.value.fold(
          (f) => f.maybeMap(
            invalidPassword: (_) => 'Contraseña invalida.\n La contraseña debe contener 8 caracteres',
            orElse: () => null,
          ),
          (_) => null,
        ),
    );
  }
}

class EmailField extends StatelessWidget {
  const EmailField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.email),
        labelText: 'Correo',
      ),
      autocorrect: false,
      onChanged: (value) => BlocProvider.of<LoginFormBloc>(context)
        .add(LoginFormEvent.emailChanged(value)),
      validator: (_) => BlocProvider.of<LoginFormBloc>(context)
          .state.emailAddress.value.fold(
            (f) => f.maybeMap(
              invalidEmail: (_) => 'Correo invalido',
              orElse: () => null,
            ),
            (_) => null,
          ),
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