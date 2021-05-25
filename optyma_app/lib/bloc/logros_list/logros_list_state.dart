part of 'logros_list_bloc.dart';

abstract class LogrosListState extends Equatable {
  const LogrosListState();
  
  @override
  List<Object> get props => [];
}

class LogrosListInitial extends LogrosListState {}

class LogrosListLoadInProgress extends LogrosListState{}

class LogrosListType1LoadSuccess extends LogrosListState{
  final List<LogroType1Model> logros;
  LogrosListType1LoadSuccess(this.logros);

  @override
  List<Object> get props => [logros];
}

class LogrosListType2LoadSuccess extends LogrosListState{
  final List<LogroType1Model> logros;
  LogrosListType2LoadSuccess(this.logros);

  @override
  List<Object> get props => [logros];
}

class LogrosListLoadFailure extends LogrosListState{}

