part of 'endless_mode_bloc.dart';

@freezed
class EndlessModeEvent with _$EndlessModeEvent {
  const factory EndlessModeEvent.started(int operationType, int difficulty) = Started;
  const factory EndlessModeEvent.answerSelected(double answer) = AnswerSelected;
  const factory EndlessModeEvent.nextQuestion() = NextQuestion;
  const factory EndlessModeEvent.ended() = Ended;
}