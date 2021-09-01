part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = Initial;
  const factory AuthState.authenticated() = Aunthenticated;
  const factory AuthState.unauthenticated() = Unaunthenticated;
}