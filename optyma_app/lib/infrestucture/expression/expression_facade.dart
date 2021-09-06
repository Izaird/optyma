import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:optyma_app/domain/expressions/expression.dart';
import 'package:optyma_app/domain/expressions/i_expression_facade.dart';

@LazySingleton(as :IExpressionFacade)
class ExpressionFacade implements IExpressionFacade{

  List<int> _expressionOptions(int result){
    final Random random = Random();
    final int variance = 2+random.nextInt(5-1);
    final List<int> expressionOptions = [
      result, 
      result-variance,
      result+variance+1,
      result+variance,
    ];
    expressionOptions.shuffle();
    return expressionOptions;
  }

  @override
  EvaluatedExpression questionInt(operationType operationType, difficulty difficulty) {
    // TODO: implement questionInt
    throw UnimplementedError();
  }
} 