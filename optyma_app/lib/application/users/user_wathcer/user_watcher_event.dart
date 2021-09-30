part of 'user_watcher_bloc.dart';

@freezed
class UserWatcherEvent with _$UserWatcherEvent {
  const factory UserWatcherEvent.watchAllStarted() = _WatchAllStarted;
  const factory UserWatcherEvent.watchAdminsStarted() = _WatchAdminsStarted;
  const factory UserWatcherEvent.watchPlayersStarted() = _WatchPlayersStarted;
  const factory UserWatcherEvent.usersReceived(Either<UserFailure, List<User>> failureOrUsers) = _UsersReceived;
}