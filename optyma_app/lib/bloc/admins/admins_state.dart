part of 'admins_bloc.dart';

abstract class AdminsState extends Equatable {
  const AdminsState();
  
  @override
  List<Object> get props => [];
}

class AdminsLoadInProgress extends AdminsState{}

class AdminsLoadSuccess extends AdminsState{
  final List<UserModel> admins;
  
  AdminsLoadSuccess(this.admins);

  @override
  List<Object> get props => [admins];
}

class AdminsLoadFailure extends AdminsState{}
