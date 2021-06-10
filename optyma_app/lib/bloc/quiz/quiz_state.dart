part of 'quiz_bloc.dart';

enum QuizStatus{loading, error, waitingAnswer, answered, timeOut, completed}


class QuizState extends Equatable {
  final QuizStatus status;
  final int currentIndex;
  final double selectedAnswer;
  final int score;
  final int streak;
  final int numberOfQuestions;
  final List<QuestionModel> questions;
  

  QuizState({
    this.status,
    this.currentIndex = 0, 
    this.selectedAnswer,
    this.score = 0,
    this.streak = 0,
    this.numberOfQuestions,
    this.questions,
  });

  @override
  List<Object> get props => [status, currentIndex, score, streak, selectedAnswer, numberOfQuestions, questions];

  QuizState copyWith({
    QuizStatus status,
    double selectedAnswer,
    int currentIndex,
    int numberOfQuestions,
    int score,
    int streak,
    List<QuestionModel> questions, }){
    return QuizState(
      status          : status ?? this.status,
      selectedAnswer          : selectedAnswer ?? this.selectedAnswer,
      currentIndex        : currentIndex ?? this.currentIndex,
      score               : score ?? this.score,
      streak              : streak ?? this.streak,
      numberOfQuestions   : numberOfQuestions ?? this.numberOfQuestions,
      questions           : questions ?? this.questions,
    );
  }
}