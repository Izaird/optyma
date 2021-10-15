part of 'pvp_mode_bloc.dart';

@freezed
class PvpModeState with _$PvpModeState {
  const factory PvpModeState({
    required Difficulty difficulty,
    required OperationType operationType,
    required int nquestions,
    //required int nquestionsj2,
    required int score1,
    required int score2,
    int? selectedAnswer,
    int? selectedAnswerj2,
    required EvaluatedExpression question,
    required bool gameOver,
    required bool answered,
    required bool answeredj2,
    required bool timeOver,
  }) = _PvpModeState;

   factory PvpModeState.initial() => PvpModeState(
    difficulty: Difficulty.none, 
    operationType: OperationType.none, 
    nquestions: 4,
    score1: 0,
    score2: 0,
    question: EvaluatedExpression.empty(), 
    gameOver: false, 
    answered: false,
    answeredj2: false, 
    timeOver: false
    );
}
