import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:optyma_app/repository/authentication_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(const LoginState());

  final AuthenticationRepository _authenticationRepository;

  void emailChanged(String email){ 
    emit(state.copyWith(  
      email: email,
    ));
  }

  void passwordChanged(String password){ 
    emit(state.copyWith(  
      password: password,
    ));
  }


  //The form has been validated
  void validated(){ 
    emit(state.copyWith(  
      status: 1,
    ));
  }

  Future<void> logInWithCredentials() async {
    if (state.status != 1) return;
    //Submission in progress
    emit(state.copyWith(status: 2));
    try {
      await _authenticationRepository.signInWithCredentials(
        email: state.email,
        password: state.password,
      );
      //Submission success
      emit(state.copyWith(status: 3));
    } on Exception {
      //Submission was a failure
      emit(state.copyWith(status: 4));
    }
  }

  Future<void> logInWithGoogle() async {
    //Submission in progress
    emit(state.copyWith(status: 2));
    try {
      await _authenticationRepository.signInWithGoogle();
      //Submission success
      emit(state.copyWith(status: 3));
    } on Exception {
      //Submission was a failure
      emit(state.copyWith(status: 4));
    } on NoSuchMethodError {
      emit(state.copyWith(status: 0));
    }
  }
}