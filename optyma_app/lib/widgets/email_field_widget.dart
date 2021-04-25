import 'package:flutter/material.dart';
import 'package:optyma_app/utils/validators.dart' as validators;


class EmailInput extends StatelessWidget {

  final FormFieldSetter<String> onSaved;

  const EmailInput({
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Correo electrónico',
        helperText: '',
      ),
      validator: (value) {
        if(validators.isEmail(value)){
          return null;
        }
        else{
          return 'Ingrese una descripción valida';
        }
      },
      onSaved: onSaved
    );
  }
}