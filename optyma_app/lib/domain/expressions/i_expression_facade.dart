import 'package:optyma_app/domain/expressions/expression.dart';

enum operationType{addition, substraction, multiplication, division}
enum difficulty{easy, medium, hard}

abstract class IExpressionFacade{
  EvaluatedExpression questionInt(
    operationType operationType, 
    difficulty difficulty, 
  );

}