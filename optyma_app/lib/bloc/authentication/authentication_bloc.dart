import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optyma_app/repository/authentication_repository.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationBloc({@required AuthenticationRepository authenticationRepository})
    : assert(authenticationRepository != null),
    _authenticationRepository = authenticationRepository, super(AuthenticationUninitialized());


  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    }
    if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    }
    if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final bool isSignedIn =  _authenticationRepository.isSignedIn();
      if (isSignedIn) {
        final user =  _authenticationRepository.getUser();

        yield await Future.delayed(Duration(seconds: 1), (){
          return AuthenticationSuccess(user.displayName);
        });
      }
      else {
        yield await Future.delayed(Duration(seconds: 5), (){
          return AuthenticationFailure();
        });
      }
    } catch (_) {
      yield AuthenticationFailure();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield AuthenticationSuccess(_authenticationRepository.getUser().displayName);
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield AuthenticationFailure();
    _authenticationRepository.signOut();
  }
}