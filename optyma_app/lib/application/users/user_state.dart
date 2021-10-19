part of 'user_bloc.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.loggedOut() = LoggedOut;
  const factory UserState.playerLogged(User player) = PlayerLogged;
  const factory UserState.adminLogged(User admin) = AdminLogged;
  const factory UserState.playerUnverified (User player) = Unverified; 
}
