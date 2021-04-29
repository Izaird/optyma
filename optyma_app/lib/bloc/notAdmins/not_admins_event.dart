part of 'not_admins_bloc.dart';

abstract class NotAdminsEvent extends Equatable {
  const NotAdminsEvent();

  @override
  List<Object> get props => [];
}


class NotAdminsLoaded extends NotAdminsEvent{}

class NotAdminsUpdated extends NotAdminsEvent{
  final List<UserModel> notAdmins;

  NotAdminsUpdated(this.notAdmins);

  @override
  List<Object> get props => [notAdmins];
}

