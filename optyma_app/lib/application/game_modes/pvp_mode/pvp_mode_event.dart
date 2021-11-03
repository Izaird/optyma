part of 'pvp_mode_bloc.dart';

@freezed
class PvpModeEvent with _$PvpModeEvent {
  const factory PvpModeEvent.started(OperationType operationType, Difficulty difficulty) = Started;
  const factory PvpModeEvent.answer1Selected(int answer, int duration, int time) = Answer1Selected;
  const factory PvpModeEvent.answer2Selected(int answer, int duration, int time) = Answer2Selected;
  const factory PvpModeEvent.timeOver() = TimeOver;
  const factory PvpModeEvent.gameOver() = GameOver;
}