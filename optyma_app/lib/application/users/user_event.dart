part of 'user_bloc.dart';

@freezed
class UserEvent with _$UserEvent {
  const factory UserEvent.loggedIn() = _LoggedIn;
  const factory UserEvent.signedUp(User user) = _SignedUp;
  const factory UserEvent.loggedOut() = _LoggedOut;
}