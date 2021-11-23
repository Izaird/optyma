part of 'classic_mode_bloc.dart';

@freezed
class ClassicModeState with _$ClassicModeState {
  const factory ClassicModeState({
    required Difficulty difficulty,
    required OperationType operationType,
    required int nquestions,
    required int streak,
    required int score,
    int? selectedAnswer,
    required EvaluatedExpression question,
    required bool gameOver,
    required bool answered,
    required bool timeOver,
    required int totalTime,
  }) = _ClassicModeState;

  factory ClassicModeState.initial() => ClassicModeState(
    difficulty: Difficulty.none,
    operationType: OperationType.none,
    nquestions: 4, 
    streak: 0, 
    score: 0, 
    question: EvaluatedExpression.empty(),
    gameOver: false, 
    answered: false, 
    timeOver: false,
    totalTime: 0,
    );
}
