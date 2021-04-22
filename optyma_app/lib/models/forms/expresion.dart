import 'package:formz/formz.dart';

enum ExpresionValidationError { invalid }

class Expresion extends FormzInput<String, ExpresionValidationError> {
  const Expresion.pure() : super.pure('');
  const Expresion.dirty([String value = '']) : super.dirty(value);

  static final RegExp _expresionRegExp = RegExp(
    r"[a-zA-Z]{10,}");

  @override
  ExpresionValidationError validator(String value) {
    return _expresionRegExp.hasMatch(value ?? '')
        ? null
        : ExpresionValidationError.invalid;
  }
}