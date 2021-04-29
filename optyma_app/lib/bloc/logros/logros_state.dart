part of 'logros_bloc.dart';

abstract class LogrosState extends Equatable {
  const LogrosState();
  
  @override
  List<Object> get props => [];
}

class LogrosLoadInProgress extends LogrosState{}

class LogrosLoadSuccess extends LogrosState{
  final List<LogroModel> logros;
  
  LogrosLoadSuccess(this.logros);

  @override
  List<Object> get props => [logros];
}

class LogrosLoadFailure extends LogrosState{}
