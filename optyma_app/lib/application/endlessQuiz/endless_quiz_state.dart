part of 'endless_quiz_bloc.dart';

enum QuizStatus{loading, error, waitingAnswer, timeOut, completed}

@freezed
class EndlessQuizState {
  QuizStatus status;
  //int currentIndex;
  double selectedAnswer;
  int score;
  int streak;
  //int numberOfQuestions;
  int mistakes;
  EvaluatedExpression question;

  EndlessQuizState({
    this.status = QuizStatus.loading,
    //this.currentIndex = 0,
    this.selectedAnswer = 0,
    this.score = 0,
    this.streak = 0,
    //required this.numberOfQuestions,
    this.mistakes=0,
    required this.question,
  });
  
  EndlessQuizState copyWith({
    QuizStatus? status,
    double? selectedAnswer,
    int? currentIndex,
    int? numberOfQuestions,
    int? score,
    int? streak,
    int? mistakes,
    List<EvaluatedExpression>? questions, }){
    return EndlessQuizState(
      status              : status ?? this.status,
      selectedAnswer      : selectedAnswer ?? this.selectedAnswer,
      //currentIndex        : currentIndex ?? this.currentIndex,
      score               : score ?? this.score,
      streak              : streak ?? this.streak,
      //numberOfQuestions   : numberOfQuestions ?? this.numberOfQuestions,
      question           : question ?? this.question,
      mistakes           : mistakes ?? this.mistakes         
    );
  }

}
