part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  final int duration;
  const TimerState(this.duration);
  
  @override
  List<Object> get props => [duration];
}

class TimerNoTime extends TimerState{
  TimerNoTime() : super(0);
}

class TimerInitialTime extends TimerState {
  const TimerInitialTime(int duration) : super(duration);
}

class TimerRunPause extends TimerState{
  TimerRunPause(int duration) : super(duration);
}

class TimerRunInProgress extends TimerState{
  TimerRunInProgress(int duration) : super(duration);
}

class TimerRunComplete extends TimerState{
  TimerRunComplete() : super(0);
}
