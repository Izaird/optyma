import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:optyma_app/domain/expressions/expression.dart';
import 'package:optyma_app/domain/expressions/i_expression_facade.dart';

@LazySingleton(as :IExpressionFacade)
class ExpressionFacade implements IExpressionFacade{
  @override
  EvaluatedExpression singleDigitAdd() {
    final Random random = Random();
    final int x = random.nextInt(10);
    final int y = random.nextInt(10);
    final int result = x + y;
    final List<double> expOptions = _expressionOptions(result.toDouble());

    return EvaluatedExpression(
      evalutedExpression: '$x + $y = $result', 
      result: result.toDouble(), 
      options: expOptions
    );
  }

  @override
  EvaluatedExpression singleDigitDiv() {
    final Random random = Random();
    final int x = random.nextInt(10);
    final int y = random.nextInt(10);
    final int result = x - y;
    final List<double> expOptions = _expressionOptions(result.toDouble());

    return EvaluatedExpression(
      evalutedExpression: '$x - $y = $result', 
      result: result.toDouble(), 
      options: expOptions
    );
  }

  @override
  EvaluatedExpression singleDigitMul() {
    final Random random = Random();
    final int x = random.nextInt(10);
    final int y = random.nextInt(10);
    final int result = x * y;
    final List<double> expOptions = _expressionOptions(result.toDouble());

    return EvaluatedExpression(
      evalutedExpression: '$x * $y = $result', 
      result: result.toDouble(), 
      options: expOptions
    );
  }

  @override
  EvaluatedExpression singleDigitSub() {
    final Random random = Random();
    final int y = random.nextInt(10);
    final int x = y * random.nextInt(10);
    final double result = x / y;
    final List<double> expOptions = _expressionOptions(result);

    return EvaluatedExpression(
      evalutedExpression: '$x / $y = $result', 
      result: result.toDouble(), 
      options: expOptions
    );
  }

  List<double> _expressionOptions(double result){
    final Random random = Random();
    final int variance = 2+random.nextInt(5-1);
    final List<double> expressionOptions = [
      result,
      result-variance,
      result+variance+1,
      result+variance,
    ];
    expressionOptions.shuffle();
    return expressionOptions;
  }
} 