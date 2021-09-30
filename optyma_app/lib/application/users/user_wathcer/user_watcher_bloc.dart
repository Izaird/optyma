import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:optyma_app/domain/users/i_user_repository.dart';
import 'package:optyma_app/domain/users/user.dart';
import 'package:optyma_app/domain/users/user_failure.dart';

part 'user_watcher_event.dart';
part 'user_watcher_state.dart';
part 'user_watcher_bloc.freezed.dart';

@injectable
class UserWatcherBloc extends Bloc<UserWatcherEvent, UserWatcherState> {
  final IUserRepository _userRepository;

  StreamSubscription<Either<UserFailure, List<User>>>? _userStreamSubscription;

  UserWatcherBloc(this._userRepository) : super(const UserWatcherState.initial());
  
  @override
  Stream<UserWatcherState> mapEventToState(UserWatcherEvent  event,) async* {
    yield* event.map(
      watchAllStarted: (e) async* {
        yield const UserWatcherState.loadInProgress();
        await _userStreamSubscription?.cancel();
        _userStreamSubscription = _userRepository.watchAll()
          .listen(
            (failureOrUsers) => add(UserWatcherEvent.usersReceived(failureOrUsers))
          );
      }, 
      watchAdminsStarted: (e) async* {
        yield const UserWatcherState.loadInProgress();
        await _userStreamSubscription?.cancel();
        _userStreamSubscription = _userRepository.watchAdmins()
          .listen(
            (failureOrUsers) => add(UserWatcherEvent.usersReceived(failureOrUsers))
          );
      }, 
      watchPlayersStarted: (e) async* {
        yield const UserWatcherState.loadInProgress();
        await _userStreamSubscription?.cancel();
        _userStreamSubscription = _userRepository.watchPlayers()
          .listen(
            (failureOrUsers) => add(UserWatcherEvent.usersReceived(failureOrUsers))
          );
      }, 
      usersReceived: (e) async* {
        yield e.failureOrUsers.fold(
          (f) => UserWatcherState.loadFailure(f), 
          (users) => UserWatcherState.loadSuccess(users)
        );
      }
    );
  }

  @override  
  Future<void> close()async{
    await _userStreamSubscription?.cancel();
    return super.close();
  }
}
