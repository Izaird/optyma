part of 'logros_bloc.dart';

abstract class LogrosEvent extends Equatable {
  const LogrosEvent();

  @override
  List<Object> get props => [];
}


class LogrosLoaded extends LogrosEvent{}

class LogrosUpdated extends LogrosEvent{
  final List<LogroModel> logros;

  LogrosUpdated(this.logros);

  @override
  // TODO: implement props
  List<Object> get props => [logros];
}

