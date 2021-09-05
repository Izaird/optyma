import 'package:freezed_annotation/freezed_annotation.dart';
part 'expression.freezed.dart';

@freezed
class EvaluatedExpression with _$EvaluatedExpression{
  const factory EvaluatedExpression({
    required String evalutedExpression,
    required double result,
    required List<double> options,
  }) = _EvaluatedExpression;
}