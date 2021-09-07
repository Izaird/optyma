import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:optyma_app/infrestucture/core/ticker.dart';

part 'timer_event.dart';
part 'timer_state.dart';
part 'timer_bloc.freezed.dart';


@injectable
class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  StreamSubscription<int>? _tickerSubscription;

  TimerBloc({required Ticker ticker}) 
  : _ticker = ticker, super(const TimerState.noTime());

  @override
  Stream<TimerState> mapEventToState( TimerEvent event,) async* {
    yield* event.map(
      started: (e) async*{
        yield TimerState.runInProgress(duration: e.duration);
        _tickerSubscription?.cancel();
        _tickerSubscription = _ticker
          .tick(thicks: e.duration) 
          .listen((duration) => add(TimerEvent.ticked(duration)));
      }, 

      paused: (e)async*{
        if(state is RunInProgress){
          _tickerSubscription?.pause();
          yield TimerState.runPause(duration: state.duration);
        }
      }, 

      resumed: (e)async*{
        if(state is RunPause){
          _tickerSubscription?.resume();
          yield TimerState.runInProgress(duration: state.duration);
        }
      }, 

      newTime: (e)async*{
        _tickerSubscription?.cancel();
        yield TimerState.initalTime(duration: e.newTime);
      }, 

      ticked: (e)async*{
        yield e.duration > 0
        ? TimerState.runInProgress(duration: e.duration)
        : const TimerState.runComplete();
      }
    );
  }


  @override 
  Future<void> close(){
    _tickerSubscription?.cancel();
    return super.close();
  }
}
