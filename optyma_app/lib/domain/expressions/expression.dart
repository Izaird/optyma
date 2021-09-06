import 'package:freezed_annotation/freezed_annotation.dart';
part 'expression.freezed.dart';

@freezed
class EvaluatedExpression with _$EvaluatedExpression{
  const factory EvaluatedExpression({
    //Only contains the expresion ie. 2+2
    required String evalutedExpression, 
    required int result, 
    required List<int> options,
  }) = _EvaluatedExpression;

  factory EvaluatedExpression.empty() => const EvaluatedExpression(
    evalutedExpression: '', 
    result: 0, 
    options: []
  );
}