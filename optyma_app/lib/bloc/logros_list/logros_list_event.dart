part of 'logros_list_bloc.dart';

abstract class LogrosListEvent extends Equatable {
  const LogrosListEvent();

  @override
  List<Object> get props => [];
}

class LogrosListType1Loaded extends LogrosListEvent{}

class LogrosListType2Loaded extends LogrosListEvent{}

class LogrosListType1Updated extends LogrosListEvent{
  final List<LogroType1Model> logros;
  LogrosListType1Updated(this.logros);

  @override
  List<Object> get props => [logros];
}

class LogrosListType2Updated extends LogrosListEvent{
  final List<LogroType1Model> logros;
  LogrosListType2Updated(this.logros);

  @override
  List<Object> get props => [logros];
}