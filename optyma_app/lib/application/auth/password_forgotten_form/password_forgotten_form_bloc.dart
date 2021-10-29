import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:optyma_app/domain/auth/auth_failure.dart';
import 'package:optyma_app/domain/auth/i_auth_facade.dart';
import 'package:optyma_app/domain/auth/value_objects.dart';

part 'password_forgotten_form_event.dart';
part 'password_forgotten_form_state.dart';
part 'password_forgotten_form_bloc.freezed.dart';



@injectable
class PasswordForgottenFormBloc extends Bloc<PasswordForgottenFormEvent, PasswordForgottenFormState> {
  final IAuthFacade _authFacade;

  PasswordForgottenFormBloc(this._authFacade) : super(PasswordForgottenFormState.initial());

  @override
  Stream<PasswordForgottenFormState> mapEventToState(PasswordForgottenFormEvent event,) async* {
    yield* event.map(
      emailChanged: (e) async* {
        yield state.copyWith(
          emailAddress: EmailAddress(e.emailStr),
          authFailureOrSuccessOption: none()
        );
      }, 
      sendEmailPressed: (e) async* {
        Either<AuthFailure, Unit>? failureOrSuccess;

        final isEmailValid = state.emailAddress.isValid();

        if(isEmailValid){
          yield state.copyWith(
            isSubmitting: true,
            authFailureOrSuccessOption: none(),
          );


          failureOrSuccess = await _authFacade.sendPasswordResetEmail(
            emailAddress: state.emailAddress
          );

        }

        yield state.copyWith(
          isSubmitting: false,
          showErrorMessages: true,
          authFailureOrSuccessOption: optionOf(failureOrSuccess)
        );
      }
    );
  }
}