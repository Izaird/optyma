part of 'login_form_bloc.dart';

@freezed
class LoginFormEvent with _$LoginFormEvent {
  const factory LoginFormEvent.emailChanged(String emailStr) = EmailChanged;
  const factory LoginFormEvent.passwordChanged(String passwordStr) = PasswordString;
  const factory LoginFormEvent.loginWithEmailAndPasswordPressed() = LoginWithEmailAndPasswordPressed;
  const factory LoginFormEvent.loginWithGooglePressed() = LoginWithGooglePressed;
}