part of 'timer_bloc.dart';

@freezed
class TimerState with _$TimerState {
  const factory TimerState.noTime({@Default(0) int duration}) = NoTime;
  const factory TimerState.initalTime({required int duration}) = IntialTime;
  const factory TimerState.runPause({required int duration}) = RunPause;
  const factory TimerState.runInProgress({required int duration}) = RunInProgress;
  const factory TimerState.runComplete({@Default(0) int duration}) = RunComplete;
}
  