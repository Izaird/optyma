import 'dart:math';

import 'package:flutter/material.dart';
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
  EvaluatedExpression questionInt(OperationType operationType, Difficulty difficulty) {
    final Random rand= Random();
    int numberOfVars=0;
    final List<int>vars = [];
    String operation='';
    List<int>listOfOptions=[];
    int result=0;
    int i=0;
    if(operationType == OperationType.addition || operationType == OperationType.substraction){
      numberOfVars = 2 + rand.nextInt(3);
    }
    else if(operationType==OperationType.multiplication){
      numberOfVars = 2 + rand.nextInt(1);
    }
    else{
      numberOfVars = 2;
    }
    if(difficulty == Difficulty.easy){
      for(i=0;i<numberOfVars;i++){
        vars.add(rand.nextInt(25)+1);
      }
    }
    else if(difficulty == Difficulty.medium){
      for(i=0;i<numberOfVars;i++){
        vars.add(rand.nextInt(99)+10);
      }
    }
    else if (difficulty == Difficulty.hard){
       for(i=0;i<numberOfVars;i++){
        vars.add(rand.nextInt(979)+20);
      }
    }

    if(operationType == OperationType.addition){
      for(i=0;i<numberOfVars;i++){
        result= result + vars[i];
        if(i == numberOfVars - 1) {
          operation = operation + vars[i].toString();
        } else{
          operation = '$operation${vars[i]}+';
        }
      }
    }
    else if(operationType == OperationType.substraction){
      result=vars[0];
      for(i=0;i<vars.length;i++){
        if(i == vars.length - 1) {
          operation = operation + vars[i].toString();
        } else{
          operation = '$operation${vars[i]}-';
        }
        for(i=1;i<vars.length;i++){
          result=result-vars[i];
        }
      }
    }
    else if(operationType == OperationType.multiplication){
      result=1;
      for(i=0;i<numberOfVars;i++){
        if(i == numberOfVars - 1) {
          operation = operation + vars[i].toString();
        } else{
          operation = '$operation${vars[i]}*';
        }
        result=result*vars[i];
      }
    }
    else if(operationType == OperationType.division){
      int factor1=0;
      int factor2=0, num1=0;

      if(difficulty==Difficulty.easy){
        factor1= rand.nextInt(12)+10;
        factor2 = rand.nextInt(10)+1;
      }
      if(difficulty==Difficulty.medium){
        factor1= rand.nextInt(30)+10;
        factor2 = rand.nextInt(16)+2;
      }if(difficulty==Difficulty.hard){
        factor1= rand.nextInt(61)+10;
        factor2 = rand.nextInt(24)+2;
      }
      num1 = factor1*factor2;
      operation = '$num1/$factor2';
      result =factor1;
    }
    else{
      debugPrint("Unexpected operation type");
    }
    listOfOptions = _expressionOptions(result);
    return EvaluatedExpression(evalutedExpression: operation, result: result, options: listOfOptions);
  }
} 