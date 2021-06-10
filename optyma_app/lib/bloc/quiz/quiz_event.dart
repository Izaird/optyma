part of 'quiz_bloc.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object> get props => [];
}

class QuizStarted extends QuizEvent{
  final int difficulty;
  final int subject;

  QuizStarted({
    this.difficulty, 
    this.subject
  });

  @override
    List<Object> get props => [difficulty, subject];
}

class QuizAnswerSelected extends QuizEvent{
  final double answer;

  QuizAnswerSelected(this.answer);
}

class QuizNextQuestion extends QuizEvent{}

class QuizTimeOver extends QuizEvent{}