import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:optyma_app/models/logros/logro_type1_model.dart';
import 'package:optyma_app/repository/logros_repository.dart';

part 'logros_list_event.dart';
part 'logros_list_state.dart';

class LogrosListBloc extends Bloc<LogrosListEvent, LogrosListState> {
  final LogrosRepository _logrosRepository;


  LogrosListBloc({@required LogrosRepository logrosRepository})
  : assert(logrosRepository != null),
  _logrosRepository = logrosRepository,
  super(LogrosListInitial());

  @override
  Stream<LogrosListState> mapEventToState(LogrosListEvent event,) async* {

    if(event is LogrosListType1Loaded){
      yield* _mapLogrosListType1LoadedToState();
    }

    if(event is LogrosListType2Loaded){
      yield* _mapLogrosListType2LoadedToState();
    }
  }

  Stream<LogrosListState> _mapLogrosListType1LoadedToState() async *{
    yield LogrosListLoadInProgress();
  }

  Stream<LogrosListState> _mapLogrosListType2LoadedToState() async *{
    yield LogrosListLoadInProgress();
  }

}