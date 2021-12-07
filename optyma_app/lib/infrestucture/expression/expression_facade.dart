import 'dart:math';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:optyma_app/domain/expressions/expression.dart';
import 'package:optyma_app/domain/expressions/i_expression_facade.dart';
import 'package:optyma_app/domain/templates/i_template_repository.dart';
import 'package:optyma_app/domain/templates/template.dart';

@LazySingleton(as :IExpressionFacade)
class ExpressionFacade implements IExpressionFacade{
  final ITemplateRepository _templateRepository; 
  ExpressionFacade(this._templateRepository);
  List<int> _expressionOptions(int result){
    final Random random = Random();
    final int variance = 2+random.nextInt(8);
    final List<int> expressionOptions = [
      result, 
      result+10,
      result+variance,
      result+variance-10,
    ];
    expressionOptions.shuffle();
    return expressionOptions;
  }

  @override
  Future<EvaluatedExpression> questionInt(OperationType operationType, Difficulty difficulty) async{
    final Random rand= Random();
    int numberOfVars=0;
    final List<int>vars = [];
    String operation='';
    List<int>listOfOptions=[];
    List<String> values = [];
    List<List<String>> aritvalues=[];
    List<Template> templatesList = []; 
    List<int> rands = [0,0,10,0,0];
    int result=0;
    int i=0;
    Parser p = Parser();
    final rng= Random();
    final failOrTemplate = await _templateRepository.getAllTemplates();

    if(operationType == OperationType.addition || operationType == OperationType.substraction){
      numberOfVars = 2 + rand.nextInt(2);
    }
    else if(operationType==OperationType.multiplication ){
      numberOfVars = 2 + rand.nextInt(1);
    }
    else if(operationType==OperationType.combined) {
      failOrTemplate.map((r) => templatesList=r);
      int index = rng.nextInt(templatesList.length);
      String plantilla =  templatesList[index].expression.getOrCrash();
      print(plantilla);
      Expression expr = p.parse(plantilla);
      //Expression expr = p.parse('a+b*c');
      if(difficulty == Difficulty.easy){
        values = templatesList[index].valuesEasy.getOrCrash().split(";");
         for (int i=0;i<values.length-1;i++){
          //print( values[i].split("-") );
          aritvalues.add(values[i].split("-"));
          rands[i] = int.parse(aritvalues[i][0]) + rng.nextInt(int.parse(aritvalues[i][1]) - int.parse(aritvalues[i][0]));
        }
        print(rands);
      }
      else if(difficulty == Difficulty.medium){
        values = templatesList[index].valuesMedium.getOrCrash().split(";");
         for (int i=0;i<values.length-1;i++){
          //print( values[i].split("-") );
          aritvalues.add(values[i].split("-"));

          rands[i] = int.parse(aritvalues[i][0]) + rng.nextInt(int.parse(aritvalues[i][1]) - int.parse(aritvalues[i][0]));
        }
        print(rands);
      }
      else if(difficulty == Difficulty.hard){
        values = templatesList[index].valuesHard.getOrCrash().split(";");
         for (int i=0;i<values.length-1;i++){
          //print( values[i].split("-") );
          aritvalues.add(values[i].split("-"));
          rands[i] = int.parse(aritvalues[i][0]) + rng.nextInt(int.parse(aritvalues[i][1]) - int.parse(aritvalues[i][0]));
        }
        print(rands);
      }
      else{
        throw UnimplementedError("Unexpected diff");
      }
      Variable a= Variable('a'), b=Variable('b') ;
      Variable c= Variable('c'), d=Variable('d');
      ContextModel cm = ContextModel()
      ..bindVariable(a, Number(rands[0]))
      ..bindVariable(b, Number(rands[1]))
      ..bindVariable(c, Number(rands[2]))
      ..bindVariable(d, Number(rands[3]));
      double eval = expr.evaluate(EvaluationType.REAL, cm) as double;
      operation = expr.toString();
      print(expr.toString());
      operation=operation.replaceAll(RegExp('a'),rands[0].toString() );
      operation=operation.replaceAll(RegExp('b'),rands[1].toString() );
      operation=operation.replaceAll(RegExp('c'),rands[2].toString() );
      operation=operation.replaceAll(RegExp('d'),rands[3].toString() );
      result = eval.toInt();
      print("***$operation***");
    }
    else{
      numberOfVars = 2;
    }
    if(difficulty == Difficulty.easy){
      
      if(operationType == OperationType.addition || operationType == OperationType.substraction){
        for(i=0;i<numberOfVars;i++){
          vars.add(rand.nextInt(99)+1);
        }
      }
      else if(operationType == OperationType.multiplication || operationType == OperationType.division){
        for(i=0;i<numberOfVars;i++){
          vars.add(rand.nextInt(9)+1);
        }
      }

    }
    else if(difficulty == Difficulty.medium){
      
      if(operationType == OperationType.addition || operationType == OperationType.substraction){
        for(i=0;i<numberOfVars;i++){
          vars.add(rand.nextInt(999)+1);
        }
      }
      else if(operationType == OperationType.multiplication || operationType == OperationType.division){
        for(i=0;i<numberOfVars;i++){
          vars.add(rand.nextInt(90)+10);
        }
      }
    }
    else if (difficulty == Difficulty.hard){
       for(i=0;i<numberOfVars;i++){
        vars.add(rand.nextInt(9980)+20);
      }
      if(operationType == OperationType.addition || operationType == OperationType.substraction){
        for(i=0;i<numberOfVars;i++){
          vars.add(rand.nextInt(100)+1);
        }
      }
      else if(operationType == OperationType.multiplication || operationType == OperationType.division){
        for(i=0;i<numberOfVars;i++){
          vars.add(rand.nextInt(90)+10);
        }
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
          // print(operation);
        } else{
          operation = '$operation${vars[i]}-';
          //operation = operation + vars[i].toString() + '-';
        } 
      }
      for(i=1;i<vars.length;i++){
        result=result-vars[i];
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