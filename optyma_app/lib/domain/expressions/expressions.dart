import 'dart:math';
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
    Parser p = Parser();
    Random rand = Random();
    List<int> numbersToReplace = [0,0,0,0,0,0,0,0]; 
    Expression expre = p.parse(this.exp);
    for(int i = 0; i<this.ranges.length;i++){
      numbersToReplace[i] = ranges[i][0] + rand.nextInt(ranges[i][1] - ranges[i][0]);
    }
    int variance = 2+rand.nextInt(5-1);
      Variable a= Variable('a'), b=Variable('b') ;
      Variable c= Variable('c'), d=Variable('d'), e=Variable('e'), f =Variable('f'), g=Variable('g');
      ContextModel cm = ContextModel()
      ..bindVariable(a, Number(numbersToReplace[0]))
      ..bindVariable(b, Number(numbersToReplace[1]))
      ..bindVariable(c, Number(numbersToReplace[2]))
      ..bindVariable(d, Number(numbersToReplace[3]))
      ..bindVariable(e, Number(numbersToReplace[4]))
      ..bindVariable(f, Number(numbersToReplace[5]))
      ..bindVariable(g, Number(numbersToReplace[6]));
      double result = expre.evaluate(EvaluationType.REAL, cm) as double;
      print('Expression: $this.exp');
      print('Evaluated expression: $result\n  (with context: $cm)');
      print(result);
      List<double> expOpc = [result,result-variance,result+variance+1,result+variance];
      String operation = exp.toString();
      operation=operation.replaceAll(RegExp(r'a'),numbersToReplace[0].toString() );
      operation=operation.replaceAll(RegExp(r'b'),numbersToReplace[1].toString() );
      operation=operation.replaceAll(RegExp(r'c'),numbersToReplace[2].toString() );
      operation=operation.replaceAll(RegExp(r'd'),numbersToReplace[3].toString() );
      // print("Operation:"+ operation);
      expOpc.shuffle();
      expOpc.shuffle();
      return EvaluatedExpression(operation, result,expOpc); 
  }
  List<EvaluatedExpression> makeXNumberOfQuestions(int n, List<MathExpression> mathExp){
    List<EvaluatedExpression> expressions =[];
    final _random = Random();
    for(int i = 0; i < n; i++){
      EvaluatedExpression temp = mathExp[_random.nextInt(mathExp.length)].makeExpression();
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