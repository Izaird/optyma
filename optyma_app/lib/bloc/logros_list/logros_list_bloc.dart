import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:optyma_app/models/logro_model.dart';

import 'package:optyma_app/repository/logros_repository.dart';

part 'logros_list_event.dart';
part 'logros_list_state.dart';

class LogrosListBloc extends Bloc<LogrosListEvent, LogrosListState> {
  final LogrosRepository _logrosRepository;
  StreamSubscription _logrosNiveSubscription;

  LogrosListBloc({@required LogrosRepository logrosRepository})
  : assert(logrosRepository != null),
  _logrosRepository = logrosRepository,
  super(LogrosListInitial());

  @override
  Stream<LogrosListState> mapEventToState(LogrosListEvent event,) async* {

    if(event is LogrosListType1Selected){
      yield* _mapLogrosListType1SelectedToState();
    }
    if(event is LogrosListType2Selected){
      yield* _mapLogrosListType2SelectedToState();
    }
    if(event is LogrosListType3Selected){
      yield* _mapLogrosListType3SelectedToState();
    }
    if(event is LogrosListType4Selected){
      yield* _mapLogrosListType4SelectedToState();
    }
    if(event is LogrosListType5Selected){
      yield* _mapLogrosListType5SelectedToState();
    }
    if(event is LogrosListLoaded){
      yield* _mapLogrosListLoadedToState();
    }
    if(event is LogrosListUpdated){
      yield* _mapLogrosListUpdatedToState(event);
    }
  }

  Stream<LogrosListState> _mapLogrosListType1SelectedToState() async *{
    yield LogrosListType1();
  }

  Stream<LogrosListState> _mapLogrosListType2SelectedToState() async *{
    yield LogrosListType2();
  }

  Stream<LogrosListState> _mapLogrosListType3SelectedToState() async *{
    yield LogrosListType3();
  }

  Stream<LogrosListState> _mapLogrosListType4SelectedToState() async *{
    yield LogrosListType4();
  }

  Stream<LogrosListState> _mapLogrosListType5SelectedToState() async *{
    yield LogrosListType5();
  }

  Stream<LogrosListState> _mapLogrosListLoadedToState() async *{
    if(state is LogrosListType1){
      yield LogrosListLoadInProgress();
      _logrosNiveSubscription?.cancel();
      try{
        _logrosNiveSubscription = _logrosRepository.getLogrosNive().listen((logros) {
          add(LogrosListUpdated(logros));
        });
      }catch(_){
        yield LogrosListLoadFailure();
      }
    }

    if(state is LogrosListType2){
      yield LogrosListLoadInProgress();
      _logrosNiveSubscription?.cancel();
      try{
        _logrosNiveSubscription = _logrosRepository.getLogrosRres().listen((logros) {
          add(LogrosListUpdated(logros));
        });
      }catch(_){
        yield LogrosListLoadFailure();
      }
    }

    if(state is LogrosListType3){
      yield LogrosListLoadInProgress();
      _logrosNiveSubscription?.cancel();
      try{
        _logrosNiveSubscription = _logrosRepository.getLogrosRdia().listen((logros) {
          add(LogrosListUpdated(logros));
        });
      }catch(_){
        yield LogrosListLoadFailure();
      }
    }

    if(state is LogrosListType4){
      yield LogrosListLoadInProgress();
      _logrosNiveSubscription?.cancel();
      try{
        _logrosNiveSubscription = _logrosRepository.getLogrosEres().listen((logros) {
          add(LogrosListUpdated(logros));
        });
      }catch(_){
        yield LogrosListLoadFailure();
      }
    }

    if(state is LogrosListType5){
      yield LogrosListLoadInProgress();
      _logrosNiveSubscription?.cancel();
      try{
        _logrosNiveSubscription = _logrosRepository.getLogrosLead().listen((logros) {
          add(LogrosListUpdated(logros));
        });
      }catch(_){
        yield LogrosListLoadFailure();
      }
    }

  }

  Stream<LogrosListState> _mapLogrosListUpdatedToState(LogrosListUpdated event) async *{
    yield LogrosListLoadSuccess(event.logros);
  }
  

  @override
  Future<void> close(){
    _logrosNiveSubscription?.cancel();
    return super.close();
  }
}