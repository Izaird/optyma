import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optyma_app/repository/authentication_repository.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authenticationRepository) : super(const SignUpState());

  final AuthenticationRepository _authenticationRepository;

  void emailChanged(String email) {
    emit(state.copyWith(
      email : email,
    ));
  }

  void passwordChanged(String password) {
    emit(state.copyWith(
      password : password,
    ));
  }

  void confirmedPasswordChanged() {
    emit(state.copyWith(
      confirmedPassword: true,
    ));
  }

  void validated(){ 
    emit(state.copyWith(  
      status: 1,
    ));
  }

  Future<void> signUpFormSubmitted() async {
    // Status is not validated
    if (state.status != 1) return;
    //Submission in progress
    emit(state.copyWith(status: 2));
    try {
      await _authenticationRepository.signUp(
        email: state.email,
        password: state.password,
      );
      //Submission was a success
      emit(state.copyWith(status: 3));
    } on Exception {
      //Submission was a failure
      emit(state.copyWith(status: 4));
    }
  }
}