part of 'timer_bloc.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class TimerStarted extends TimerEvent{
  final int duration;

  TimerStarted({
    @required this.duration
  });
}

class TimerPaused extends TimerEvent{}

class TimerResumed extends TimerEvent{}

class TimerNewTime extends TimerEvent{
  final int newTime;

  TimerNewTime({
    @required this.newTime
  });
  
  @override
    List<Object> get props => [newTime];
}

class TimerTicked extends TimerEvent{
  final int duration;

  TimerTicked({
    @required this.duration
  });

  @override
    List<Object> get props => [duration];
}
