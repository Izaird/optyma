import 'package:optyma_app/domain/expressions/expression.dart';

enum OperationType{none, addition, substraction, multiplication, division, combined}
enum Difficulty{none, easy, medium, hard}

abstract class IExpressionFacade{
  EvaluatedExpression questionInt(
    OperationType operationType, 
    Difficulty difficulty, 
  );

}