part of 'endless_mode_bloc.dart';

@freezed
class EndlessModeEvent with _$EndlessModeEvent {
  const factory EndlessModeEvent.started(OperationType operationType, Difficulty difficulty) = Started;
  const factory EndlessModeEvent.answerSelected(int answer, int duration) = AnswerSelected;
  const factory EndlessModeEvent.timeOver() = TimeOver;
  const factory EndlessModeEvent.gameOver() = GameOver;
}