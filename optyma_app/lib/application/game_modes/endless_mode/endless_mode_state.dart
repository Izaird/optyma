part of 'endless_mode_bloc.dart';

@freezed
class EndlessModeState with _$EndlessModeState {
  const factory EndlessModeState({
    required int strake,
    required int score, 
    required EvaluatedExpression question, 
  }) = _EndlessModeState;

  // const factory EndlessModeState.initial() = _Initial;
  factory EndlessModeState.initial() => EndlessModeState(
    strake: 0,
    score: 0,
    question: EvaluatedExpression.empty(),
  );
}
