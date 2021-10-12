import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/application/auth/auth_bloc.dart';
import 'package:optyma_app/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:optyma_app/application/users/user_bloc.dart';
import 'package:optyma_app/domain/core/value_objects.dart';
import 'package:optyma_app/domain/users/user.dart';

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
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            (_) {
              //*It's ok that this user doesn't have an unique id.
              final user = User(
                id: UniqueId.fromUniqueString(''), 
                emailAddress: state.emailAddress
              );
              BlocProvider.of<UserBloc>(context).add(UserEvent.signedUp(user));
              context.read<AuthBloc>().add(const AuthEvent.authCheckRequested());
              Navigator.pop(context);
            },
          ),
        );
      },
      builder: (context, state) {
        return Form(
          autovalidateMode: BlocProvider.of<SignInFormBloc>(context).state.showErrorMessages ? AutovalidateMode.always : AutovalidateMode.disabled,
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: [
              const Logo(),
              const SizedBox(height: 8),


              const EmailField(),
              const SizedBox(height: 8),


              const PasswordField(),
              const SizedBox(height: 8),


              const PasswordConfirmationField(),
              const SizedBox(height: 8),


              const RegisterButton(),

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

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
     onPressed: () {
       BlocProvider.of<SignInFormBloc>(context).add(
             const SignInFormEvent
                 .registerWithEmailAndPasswordPressed(),
           );
     },
     child: const Text('Registrarse'),
      );
  }
}


class PasswordField extends StatelessWidget {
  const PasswordField({
    Key? key,
  }) :  super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
            invalidPassword: (_) => 'Contraseña invalida',
            orElse: () => null,
          ),
          (_) => null,
        ),
    );
  }
}


class PasswordConfirmationField extends StatelessWidget {
  const PasswordConfirmationField({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.lock),
        labelText: 'Confirmar contraseña',
      ),
      autocorrect: false,
      obscureText: true,

      onChanged: (value) => BlocProvider.of<SignInFormBloc>(context)
        .add(SignInFormEvent.confirmPasswordChanged(value)),

      validator: (_) {
        if(!BlocProvider.of<SignInFormBloc>(context).state.isSamePassword){
          return 'Contraseña no coincide';
        }
        else{
          return null;
        }
      }
      
    
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