part of 'login_cubit.dart';


class LoginState extends Equatable {

  final String email;
  final String password;

  //      ---->>status<<----
  //  invalid               == 0 
  //  isValidated           == 1 
  //  submissionInProgress  == 2 
  //  submissionSuccess     == 3
  //  submissionFailure     == 4 
  final int status;

  const LoginState({
    this.email,
    this.password,
    this.status = 0,
  });


  @override
  List<Object> get props => [email, password, status];

  LoginState copyWith({
    String email,
    String password,
    int status,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}