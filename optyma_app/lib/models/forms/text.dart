import 'package:formz/formz.dart';

enum TextValidationError { invalid }

class Text extends FormzInput<String, TextValidationError> {
  const Text.pure() : super.pure('');
  const Text.dirty([String value = '']) : super.dirty(value);

  static final RegExp _emailRegExp = RegExp(
    r"[a-zA-Z ]{10,}");

  @override
  TextValidationError validator(String value) {
    return _emailRegExp.hasMatch(value ?? '')
        ? null
        : TextValidationError.invalid;
  }
}