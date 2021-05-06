import 'package:flutter/material.dart';
import 'package:optyma_app/utils/validators.dart' as validators;


class TextInput extends StatelessWidget {

  final FormFieldSetter<String> onSaved;
  final int maxLenght;
  final String labelText;
  final TextEditingController textEditingController;
  final String intialValue;

  const TextInput({
    this.intialValue,
    this.onSaved,
    this.maxLenght = 35,
    this.labelText = '',
    this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: intialValue,
      controller: textEditingController,
      maxLength: maxLenght,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      validator: (value) {
        if(validators.isText(value)){
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