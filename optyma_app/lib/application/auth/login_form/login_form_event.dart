part of 'login_form_bloc.dart';

@freezed
class LoginFormEvent with _$LoginFormEvent {
  const factory LoginFormEvent.emailChanged(String emailStr) = EmailChanged;
  const factory LoginFormEvent.passwordChanged(String passwordStr) = PasswordString;
  const factory LoginFormEvent.LoginWithEmailAndPasswordPressed() = LoginWithEmailAndPasswordPressed;
  const factory LoginFormEvent.LoginWithGooglePressed() = LoginWithGooglePressed;
}