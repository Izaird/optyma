part of 'logros_list_bloc.dart';

abstract class LogrosListEvent extends Equatable {
  const LogrosListEvent();

  @override
  List<Object> get props => [];
}

class LogrosListType1Selected extends LogrosListEvent{}

class LogrosListType2Selected extends LogrosListEvent{}

class LogrosListType3Selected extends LogrosListEvent{}

class LogrosListType4Selected extends LogrosListEvent{}

class LogrosListType5Selected extends LogrosListEvent{}

class LogrosListLoaded extends LogrosListEvent{}

class LogrosListUpdated extends LogrosListEvent{
  final List<LogroModel> logros;
  LogrosListUpdated(this.logros);

  @override
  List<Object> get props => [logros];
}

class LogrosListType2Updated extends LogrosListEvent{
  final List<LogroType1Model> logros;
  LogrosListType2Updated(this.logros);

  @override
  List<Object> get props => [logros];
}