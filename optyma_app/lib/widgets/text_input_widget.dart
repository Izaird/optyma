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

class TextPlantillaInput extends StatelessWidget {

  final FormFieldSetter<String> onSaved;
  final int maxLenght;
  final String labelText;
  final TextEditingController textEditingController;
  final String intialValue;

  const TextPlantillaInput({
    this.intialValue,
    this.onSaved,
    this.maxLenght = 80,
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
        if(validators.isPlantilla(value)){
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

class TextTimeInput extends StatelessWidget {

  final FormFieldSetter<String> onSaved;
  final int maxLenght;
  final String labelText;
  final TextEditingController textEditingController;
  final String intialValue;

  const TextTimeInput({
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
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      validator: (value) {
        if(validators.isDigit(value)){
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
class TextValuesInput extends StatelessWidget {

  final FormFieldSetter<String> onSaved;
  final int maxLenght;
  final String labelText;
  final TextEditingController textEditingController;
  final String intialValue;

  const TextValuesInput({
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
        if(validators.isValues(value)){
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