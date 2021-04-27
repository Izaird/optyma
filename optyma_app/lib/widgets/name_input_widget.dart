import 'package:flutter/material.dart';
import 'package:optyma_app/utils/validators.dart' as validators;


class NameInput extends StatelessWidget {

  final FormFieldSetter<String> onSaved;
  final int maxLenght;
  final String labelText;
  final TextEditingController textEditingController;

  const NameInput({
    this.onSaved,
    this.maxLenght = 20,
    this.labelText = '',
    this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      maxLength: maxLenght,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      validator: (value) {
        if(validators.isName(value)){
          return null;
        }
        else{
          return 'Ingrese un texto valido';
        }
      },
      onSaved: onSaved
    );
  }
}