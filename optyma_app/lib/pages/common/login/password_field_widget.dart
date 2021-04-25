import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/cubit/login/login_cubit.dart';
import 'package:optyma_app/utils/validators.dart' as validators;


class PasswordInput extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Contraseña',
        helperText: '',
      ),
      validator: (value) {
        if(validators.isPassword(value)){
          return null;
        }
        else{
          return 'Ingrese una descripción valida';
        }
      },
      onSaved: (password){
        BlocProvider.of<LoginCubit>(context).passwordChanged(password);
      },
    );
  }
}
