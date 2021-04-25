import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/bloc/authentication/authentication_bloc.dart';
import 'package:optyma_app/bloc/user/user_bloc.dart';
import 'package:optyma_app/cubit/signup/signup_cubit.dart';
import 'package:optyma_app/widgets/email_field_widget.dart';
import 'package:optyma_app/utils/validators.dart' as validators;
import 'package:optyma_app/widgets/text_field_widget.dart';



class SignUpForm extends StatelessWidget {
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _apellido = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        //Submission was a failure
        if (state.status == 4) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Ocurrió un error en el registro')),
            );
        }
        //Submission was a success
        if(state.status == 3){
          BlocProvider.of<UserBloc>(context).add(UserSignedUp('${_nombre.text} ${_apellido.text}'));
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          Navigator.pop(context);
        }
      },
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              EmailInput(
                onSaved:(email){
                  BlocProvider.of<SignUpCubit>(context).emailChanged(email);
                },
              ),
              const SizedBox(height: 8.0),
              _passwordInput(context),
              const SizedBox(height: 8.0),
              _confirmPasswordInput(context),
              const SizedBox(height: 8.0),
              TextInput(
                labelText: 'Ingrese su nombre(s)',
                textEditingController: _nombre,
                maxLenght: 16,
              ),
              const SizedBox(height: 8.0),
              TextInput(
                labelText: 'Ingrese su apellido(s)',
                textEditingController: _apellido,
                maxLenght: 16,
                ),
              const SizedBox(height: 8.0),

              _signUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _passwordInput(BuildContext context){
    return TextFormField(
      controller: _password,
      obscureText: true, 
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: 'Contraseña',
        helperText: '',
      ),
      validator: (value) {
        if(validators.isPassword(value)){
          return null;
        }
        else{
          return 'Ingrese una contraseña valida';
        }
      },
      onSaved : (password){
        BlocProvider.of<SignUpCubit>(context).passwordChanged(password);
      },
    );
  }

  Widget _confirmPasswordInput(BuildContext context){
    return TextFormField(
      obscureText: true,
      controller: _confirmPassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: 'Vuelva a escribir su contraseña',
        helperText: '',
      ),
      validator: (value) {
        if(value == _password.text){
          return null;
        }
        else{
          return 'Las contraseñas no coinciden';
        }
      },
      onSaved : (password){
        BlocProvider.of<SignUpCubit>(context).confirmedPasswordChanged();
      },
    );
  }


  Widget _signUpButton() {

    return BlocBuilder<SignUpCubit, SignUpState>(
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
            child: const Text('Regístrarse'),
            //Submission is validated
            onPressed: (){
              if(!formKey.currentState.validate()) return;
              formKey.currentState.save();
              BlocProvider.of<SignUpCubit>(context).validated();
              BlocProvider.of<SignUpCubit>(context).signUpFormSubmitted();
            }
          );
      },
    );
  }
}