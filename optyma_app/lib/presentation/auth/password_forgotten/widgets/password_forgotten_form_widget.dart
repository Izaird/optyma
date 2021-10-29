import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/application/auth/password_forgotten_form/password_forgotten_form_bloc.dart';

class PasswordForgottenForm extends StatelessWidget {
  const PasswordForgottenForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PasswordForgottenFormBloc, PasswordForgottenFormState>(
      listener: (context, state){
        state.authFailureOrSuccessOption.fold(
          () {},
          (either) => either.fold(
            (failure) {
              final snackBar = SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(failure.map(
                  cancelledByUser: (_) => 'Cancelado',
                  userNotFound: (_) => 'Este correo no se encuentra registrado',
                  serverError: (_) => 'Error del servidor',
                  emailAlreadyInUse: (_) => 'Correo ya registrado',
                  invalidEmailAndPasswordCombination: (_) =>
                      'Combinación invalida de correo y contraseña', 
                )),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            (_) {
              const snackBar = SnackBar(
                content: Text("Se envio el correo para reestablecer contraseña"),
                duration: Duration(seconds: 15),
                backgroundColor: Colors.green,
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        );
      },
      builder: (context, state){
        return Form(
          autovalidateMode: state.showErrorMessages 
            ? AutovalidateMode.always 
            : AutovalidateMode.disabled,
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: [

              const EmailField(),
              const SizedBox(height: 8),


              const SendEmailButton(),

              if(BlocProvider.of<PasswordForgottenFormBloc>(context).state.isSubmitting)...[
                const SizedBox(height: 8),
                const LinearProgressIndicator(),  
              ]
            ],
          )
        );
      },
    );
  }
}



class SendEmailButton extends StatelessWidget {
  const SendEmailButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        BlocProvider.of<PasswordForgottenFormBloc>(context).add(
          const PasswordForgottenFormEvent.sendEmailPressed(),
        );
      },
      child: const Text('Enviar correo'),
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
      onChanged: (value) => BlocProvider.of<PasswordForgottenFormBloc>(context)
        .add(PasswordForgottenFormEvent.emailChanged(value)),
      validator: (_) => BlocProvider.of<PasswordForgottenFormBloc>(context)
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