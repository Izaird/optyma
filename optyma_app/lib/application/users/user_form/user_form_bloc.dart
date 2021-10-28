import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:optyma_app/domain/users/i_user_repository.dart';
import 'package:optyma_app/domain/users/user.dart';
import 'package:optyma_app/domain/users/user_failure.dart';

part 'user_form_event.dart';
part 'user_form_state.dart';
part 'user_form_bloc.freezed.dart';


@injectable
class UserFormBloc extends Bloc<UserFormEvent, UserFormState> {

  final IUserRepository _userRepository;

  UserFormBloc(this._userRepository): super(UserFormState.initial());


  @override
  Stream<UserFormState> mapEventToState(UserFormEvent event) async* {
    yield* event.map(
      initialized: (e) async*{
        yield e.initialUserOption.fold(
          () => state,
          (initalUser) => state.copyWith( 
            user: initalUser,
            isEditing: true, 
          )
        );
      }, 
      isAdminChanged: (e) async* {
        yield state.copyWith(
          user: state.user.copyWith(admin: e.isAdmin),
          saveFailureOrSuccessOption: none(),
        );
      }, 
      saved: (e) async* {
        Either<UserFailure, Unit> failureOrSuccess;
        yield state.copyWith(
          isSaving: true,
          saveFailureOrSuccessOption: none()
        );

        failureOrSuccess = await _userRepository.update(state.user);

        yield state.copyWith(
          isSaving: false,
          showErrorMessages: true,
          saveFailureOrSuccessOption: optionOf(failureOrSuccess)
        );

      }
    );
  }
}