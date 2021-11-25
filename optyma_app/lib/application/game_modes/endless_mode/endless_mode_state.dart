part of 'endless_mode_bloc.dart';

@freezed
class EndlessModeState with _$EndlessModeState {
  const factory EndlessModeState({
    required Difficulty difficulty,
    required OperationType operationType,
    required int lifes,
    required int streak,
    required int score,
    int? selectedAnswer,
    required EvaluatedExpression question,
    required bool gameOver,
    required bool answered,
    required bool timeOver,
    required int bestStreak,
  }) = _EndlessModeState;

  factory EndlessModeState.initial() => EndlessModeState(
    difficulty: Difficulty.none,
    operationType: OperationType.none,
    lifes: 3, 
    streak: 0, 
    score: 0, 
    question: EvaluatedExpression.empty(),
    gameOver: false, 
    answered: false, 
    timeOver: false,
    bestStreak: 0,
  );
}