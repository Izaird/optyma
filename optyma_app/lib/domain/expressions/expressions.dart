import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:math_expressions/math_expressions.dart';

class EvaluatedExpression{
  String evaluatedExpression;
  double result;
  List<double> options;
  EvaluatedExpression(
    this.evaluatedExpression,
    this.result,
    this.options
  );
}



class MathExpression{
  String exp;
  List<List<int>> ranges = [];
  int diff;

  MathExpression(
    this.exp,
    this.ranges,
    this.diff,
    );
    
  EvaluatedExpression makeExpression(){
    final Parser p = Parser();
    final Random rand = Random();
    final List<int> numbersToReplace = [0,0,0,0,0,0,0,0]; 
    final Expression expre = p.parse(exp);
    for(int i = 0; i<ranges.length;i++){
      numbersToReplace[i] = ranges[i][0] + rand.nextInt(ranges[i][1] - ranges[i][0]);
    }
    final int variance = 2+rand.nextInt(5-1);
      final Variable a= Variable('a'), b=Variable('b') ;
      final Variable c= Variable('c'), d=Variable('d'), e=Variable('e'), f =Variable('f'), g=Variable('g');
      final ContextModel cm = ContextModel()
      ..bindVariable(a, Number(numbersToReplace[0]))
      ..bindVariable(b, Number(numbersToReplace[1]))
      ..bindVariable(c, Number(numbersToReplace[2]))
      ..bindVariable(d, Number(numbersToReplace[3]))
      ..bindVariable(e, Number(numbersToReplace[4]))
      ..bindVariable(f, Number(numbersToReplace[5]))
      ..bindVariable(g, Number(numbersToReplace[6]));
      final double result = expre.evaluate(EvaluationType.REAL, cm) as double;
      debugPrint('Expression: $this.exp');
      debugPrint('Evaluated expression: $result\n  (with context: $cm)');
      debugPrint(result.toString());
      final List<double> expOpc = [result,result-variance,result+variance+1,result+variance];
      String operation = exp.toString();
      operation=operation.replaceAll(RegExp('a'),numbersToReplace[0].toString() );
      operation=operation.replaceAll(RegExp('b'),numbersToReplace[1].toString() );
      operation=operation.replaceAll(RegExp('c'),numbersToReplace[2].toString() );
      operation=operation.replaceAll(RegExp('d'),numbersToReplace[3].toString() );
      expOpc.shuffle();
      return EvaluatedExpression(operation, result, expOpc); 
  }
  List<EvaluatedExpression> makeXNumberOfQuestions(int n, List<MathExpression> mathExp){
    final List<EvaluatedExpression> expressions =[];
    final _random = Random();
    for(int i = 0; i < n; i++){
      final EvaluatedExpression temp = mathExp[_random.nextInt(mathExp.length)].makeExpression();
      expressions.add(temp);    
    }
    return expressions;
  } 
}

/*void main(List<String> args) {
  MathExpression test = MathExpression("a+b+c",[[2,10],[20,30],[25,40]],1);
  EvaluatedExpression evtest = test.makeExpression();
  print(evtest.evaluatedExpression);
*/