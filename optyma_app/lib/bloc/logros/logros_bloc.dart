import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:optyma_app/models/logro_model.dart';
import 'package:optyma_app/repository/logros_repository.dart';

part 'logros_event.dart';
part 'logros_state.dart';

class LogrosBloc extends Bloc<LogrosEvent, LogrosState> {

  final LogrosRepository _logrosRepository;
  StreamSubscription _logroSubscription;

  LogrosBloc({@required LogrosRepository logrosRepository})
    : assert(logrosRepository != null),
    _logrosRepository = logrosRepository,
    super(LogrosLoadInProgress());

  @override
  Stream<LogrosState> mapEventToState(LogrosEvent event,) async* {
    if(event is LogrosLoaded){
      yield* _mapLogrosLoadToState();
    }
    if(event is LogrosUpdated){
      yield * _mapLogrosUpdateToState(event);
    }
  }


  Stream<LogrosState> _mapLogrosLoadToState() async *{
    yield LogrosLoadInProgress();
    _logroSubscription?.cancel();
    try {
      _logroSubscription = _logrosRepository.getLogros().listen((logros) {
        add(LogrosUpdated(logros));
       });
      // final List<LogroModel> logros = await _logrosRepository.getLogros().first;
      // yield LogrosLoaded(logros);
    }
    catch (_) {
      yield LogrosLoadFailure();
    }
  }

  Stream<LogrosState> _mapLogrosUpdateToState(LogrosUpdated event) async *{
    yield LogrosLoadSuccess(event.logros);
  }


  @override
  Future<void> close() {
    _logroSubscription?.cancel();
    return super.close();
  }
}
