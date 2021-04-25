import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:optyma_app/bloc/authentication/authentication_bloc.dart';
import 'package:optyma_app/cubit/login/login_cubit.dart';
import 'package:optyma_app/pages/common/login/buttons.dart';
import 'package:optyma_app/pages/common/login/password_field_widget.dart';
import 'package:optyma_app/widgets/email_field_widget.dart';


class LoginForm extends StatelessWidget {

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        //Submission is failure
        if (state.status == 4) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(content: Text('Authentication Failure')),
          );
        }
        //Subission was a success
        if(state.status == 3){
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset( 'assets/logo.png', height: 120,),
              const SizedBox(height: 16.0),


              //Inputs
              EmailInput(
                onSaved:  (email){
                  BlocProvider.of<LoginCubit>(context).emailChanged(email);
                },
              ),
              const SizedBox(height: 8.0),
              PasswordInput(),
              const SizedBox(height: 8.0),


              //Buttons
              _loginButton(),
              const SizedBox(height: 8.0),
              GoogleLoginButton(),
              const SizedBox(height: 4.0),
              SignUpButton(),
            ],
          ),
        ),
      ),
    );

  }



  Widget _loginButton() {

    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        //Submission is in progress
        return state.status == 2
          ? const CircularProgressIndicator()
          : ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: const Text('Iniciar sesión'),
            //Submission is validated
            onPressed: (){
              if(!formKey.currentState.validate()) return;
              formKey.currentState.save();
              BlocProvider.of<LoginCubit>(context).validated();
              BlocProvider.of<LoginCubit>(context).logInWithCredentials();
            }
          );
      },
    );
  }
}