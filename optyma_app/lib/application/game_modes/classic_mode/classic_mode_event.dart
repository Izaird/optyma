part of 'classic_mode_bloc.dart';

@freezed
class ClassicModeEvent with _$ClassicModeEvent {
  const factory ClassicModeEvent.started(OperationType operationType, Difficulty difficulty) = Started;
  const factory ClassicModeEvent.answerSelected(int answer, int duration) = AnswerSelected;
  const factory ClassicModeEvent.timeOver() = TimeOver;
  const factory ClassicModeEvent.gameOver() = GameOver;
}