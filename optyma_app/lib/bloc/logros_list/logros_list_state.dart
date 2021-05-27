part of 'logros_list_bloc.dart';

abstract class LogrosListState extends Equatable {
  const LogrosListState();
  
  @override
  List<Object> get props => [];
}

class LogrosListInitial extends LogrosListState {}

class LogrosListType1 extends LogrosListState {}

class LogrosListType2 extends LogrosListState {}

class LogrosListType3 extends LogrosListState {}

class LogrosListType4 extends LogrosListState {}

class LogrosListType5 extends LogrosListState {}

class LogrosListLoadInProgress extends LogrosListState{}

class LogrosListLoadSuccess extends LogrosListState{
  final List<LogroModel> logros;
  LogrosListLoadSuccess(this.logros);

  @override
  List<Object> get props => [logros];
}


class LogrosListLoadFailure extends LogrosListState{}

