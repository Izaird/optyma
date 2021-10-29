part of 'password_forgotten_form_bloc.dart';

@freezed
class PasswordForgottenFormState with _$PasswordForgottenFormState {
  const factory PasswordForgottenFormState({
    required EmailAddress emailAddress,
    required bool showErrorMessages,
    required bool isSubmitting,
    required Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption,
  }) = _PasswordForgottenFormState;


  factory PasswordForgottenFormState.initial() => PasswordForgottenFormState(
    emailAddress: EmailAddress(''), 
    showErrorMessages: false, 
    isSubmitting: false, 
    authFailureOrSuccessOption: none()
  );
}
