part of 'user_form_bloc.dart';

@freezed
class UserFormEvent with _$UserFormEvent {
  const factory UserFormEvent.initialized(Option<User> initialUserOption) = _Initialized;
  const factory UserFormEvent.isAdminChanged({required bool isAdmin}) = _IsAdminChanged;
  const factory UserFormEvent.saved() = _Saved;
}