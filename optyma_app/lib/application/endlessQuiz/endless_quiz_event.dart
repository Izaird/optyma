part of 'endless_quiz_bloc.dart';

@freezed
class EndlessQuizEvent {
  //const factory EndlessQuizEvent.started() = _Started;
  const EndlessQuizEvent();
}
class EndlessQuizStarted extends EndlessQuizEvent{

}

class EndlessQuizAnswerSelected extends EndlessQuizEvent{

}

class EndlessQuizTimeOver extends EndlessQuizEvent{

}