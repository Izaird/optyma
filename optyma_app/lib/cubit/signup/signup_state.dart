part of 'signup_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

class SignUpState extends Equatable {

  final String email;
  final String password;
  final bool confirmedPassword;


  //      ---->>status<<----
  //  invalid               == 0 
  //  isValidated           == 1 
  //  submissionInProgress  == 2 
  //  submissionSuccess     == 3
  //  submissionFailure     == 4 
  final int status;


  const SignUpState({
    this.email,
    this.password,
    this.confirmedPassword,
    this.status,
  });


  @override
  List<Object> get props => [email, password, confirmedPassword, status];

  SignUpState copyWith({
    String email,
    String password,
    bool confirmedPassword,
    int status,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
    );
  }
}