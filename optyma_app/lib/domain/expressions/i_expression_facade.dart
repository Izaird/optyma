import 'package:optyma_app/domain/expressions/expression.dart';

abstract class IExpressionFacade{
  EvaluatedExpression singleDigitAdd();
  EvaluatedExpression singleDigitSub();
  EvaluatedExpression singleDigitDiv();
  EvaluatedExpression singleDigitMul();
}