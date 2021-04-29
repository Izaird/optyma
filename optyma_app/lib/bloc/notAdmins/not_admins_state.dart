part of 'not_admins_bloc.dart';

abstract class NotAdminsState extends Equatable {
  const NotAdminsState();
  
  @override
  List<Object> get props => [];
}

class NotAdminsLoadInProgress extends NotAdminsState{}

class NotAdminsLoadSuccess extends NotAdminsState{
  final List<UserModel> notAdmins;
  
  NotAdminsLoadSuccess(this.notAdmins);

  @override
  List<Object> get props => [notAdmins];
}

class NotAdminsLoadFailure extends NotAdminsState{}
