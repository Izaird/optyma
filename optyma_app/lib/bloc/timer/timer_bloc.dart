import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:optyma_app/repository/ticker.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;

  StreamSubscription<int> _tickerSubscription;

  TimerBloc({@required Ticker ticker}) 
    : _ticker = ticker, 
      super(TimerNoTime());

  @override
  Stream<TimerState> mapEventToState( TimerEvent event,) async* {
    if(event is TimerStarted){
      yield* _mapTimerStartedToState(event);
    }
    if(event is TimerPaused){
      yield* _mapTimerPausedToState(event);
    }
    if(event is TimerResumed){
      yield* _mapTimerResumedToState(event);
    }
    if(event is TimerTicked){
      yield* _mapTimerTickedToState(event);
    }
    if(event is TimerNewTime){
      yield* _mapTimerNewTimeToState(event);
    }
  }

  Stream<TimerState> _mapTimerStartedToState(TimerStarted start) async*{
    yield TimerRunInProgress(start.duration);
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
      .tick(thicks: start.duration)
      .listen((duration) => add(TimerTicked(duration: duration)));
  }

  Stream<TimerState> _mapTimerPausedToState(TimerPaused pause) async*{
    if(state is TimerRunInProgress){
      _tickerSubscription?.pause();
      yield TimerRunPause(state.duration);
    }
  }

  Stream<TimerState> _mapTimerResumedToState(TimerResumed resume) async*{
    if(state is TimerRunPause) {
      _tickerSubscription?.resume();
      yield TimerRunInProgress(state.duration);
    }
  }

  Stream<TimerState> _mapTimerNewTimeToState(TimerNewTime newTime) async*{
    _tickerSubscription?.cancel();
    yield TimerInitialTime(newTime.newTime);
  }

  Stream<TimerState> _mapTimerTickedToState(TimerTicked tick) async*{
    yield tick.duration > 0
      ? TimerRunInProgress(tick.duration)
      : TimerRunComplete();
  }

  @override 
  Future<void> close(){
    _tickerSubscription?.cancel();
    return super.close();
  }
}
