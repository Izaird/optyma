part of 'endless_quiz_bloc.dart';

@freezed
class EndlessQuizEvent with _$EndlessQuizEvent {
  const factory EndlessQuizEvent.started() = _Started;
}