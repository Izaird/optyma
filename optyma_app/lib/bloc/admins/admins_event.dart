part of 'admins_bloc.dart';

abstract class AdminsEvent extends Equatable {
  const AdminsEvent();

  @override
  List<Object> get props => [];
}


class AdminsLoaded extends AdminsEvent{}

class AdminsUpdated extends AdminsEvent{
  final List<UserModel> admins;

  AdminsUpdated(this.admins);

  @override
  List<Object> get props => [admins];
}

