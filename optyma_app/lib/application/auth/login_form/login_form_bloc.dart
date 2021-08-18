import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:optyma_app/domain/auth/auth_failure.dart';
import 'package:optyma_app/domain/auth/i_auth_facade.dart';
import 'package:optyma_app/domain/auth/value_objects.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';
part 'login_form_bloc.freezed.dart';


@injectable
class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  final IAuthFacade _authFacade;

  LoginFormBloc(this._authFacade) : super(LoginFormState.initial());

  @override
  Stream<LoginFormState> mapEventToState( LoginFormEvent event,) async* {

    yield* event.map(
      emailChanged: (e) async* {
        yield state.copyWith(
          emailAddress: EmailAddress(e.emailStr),
          //Whe the value of email change the response from the server need to
          //reseted as well.
          authFailureOrSuccessOption: none(),
        );
      },
      passwordChanged: (e) async* {
        yield state.copyWith(
          password: Password(e.passwordStr),
          //Whe the value of password change the response from the server need to
          //reseted as well.
          authFailureOrSuccessOption: none(),
        );
      },
      loginWithEmailAndPasswordPressed: (e) async* {
        yield* _performActionOnAuthFacadeWithEmailAndPassword(
          _authFacade.signInWithEmailAndPassword,
        );
      },
      loginWithGooglePressed: (e) async* {
        yield state.copyWith(
          isSubmitting: true,
          authFailureOrSuccessOption: none(),
        );
        final failureOrSuccess = await _authFacade.signInWithGoogle();
        yield state.copyWith(
          isSubmitting: false,
          authFailureOrSuccessOption: some(failureOrSuccess),
        );
      },
    );
  }

  Stream<LoginFormState> _performActionOnAuthFacadeWithEmailAndPassword(
    Future<Either<AuthFailure, Unit>> Function({
      required EmailAddress emailAddress,
      required Password password,
    }) forwardedCall,
  ) async* {
    Either<AuthFailure, Unit>? failureOrSuccess;
    final isEmailValid = state.emailAddress.isValid();
    final isPasswordValid = state.password.isValid();
    final emailAndPassWordIsValid = isEmailValid && isPasswordValid;

    if (emailAndPassWordIsValid) {
      yield state.copyWith(
        isSubmitting: true,
        authFailureOrSuccessOption: none(),
      );

      failureOrSuccess = await forwardedCall(
        emailAddress: state.emailAddress,
        password: state.password,
      );
    }

    yield state.copyWith(
      isSubmitting: false,
      showErrorMessages: true,
      authFailureOrSuccessOption: optionOf(failureOrSuccess),
    );
  }
}
