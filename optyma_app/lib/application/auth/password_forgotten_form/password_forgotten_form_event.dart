part of 'password_forgotten_form_bloc.dart';

@freezed
class PasswordForgottenFormEvent with _$PasswordForgottenFormEvent {
  const factory PasswordForgottenFormEvent.emailChanged(String emailStr) = _EmailChanged;
  const factory PasswordForgottenFormEvent.sendEmailPressed() = _SendEmailPressed;
}