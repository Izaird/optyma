import 'package:optyma_app/models/plantilla_model.dart';
import 'package:optyma_app/models/question_model.dart';
import 'package:optyma_app/repository/plantillas_repository.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math';

class QuestionsRepository{

  final PlantillasRepository _plantillasRepository;

  QuestionsRepository(this._plantillasRepository);


  Future<List<QuestionModel>> getQuestionsArit({int difficulty, int numberOfQuestions}) async{

    List<QuestionModel> questions=[];
    Parser p = Parser();
    List<List<String>> aritvalues=[];
    int questionTime;
    List<int> rands = [0,0,0,0];
    Random rnd = new Random();
    List<PlantillaModel> plantillas = await 
    _plantillasRepository.getPlantillasByDifAndSubj(difficulty:difficulty, subject: 1);

    if(plantillas.length > 5){
      plantillas.shuffle();
      plantillas = plantillas.sublist(0, 5);
    }

    plantillas.forEach((plantilla) {
      Expression exp = p.parse(plantilla.expression);
      List<String> values = plantilla.values.split(";");
      for (int i=0;i<values.length-1;i++){
        //print( values[i].split("-") );
        aritvalues.add(values[i].split("-"));
        rands[i] = int.parse(aritvalues[i][0]) + rnd.nextInt(int.parse(aritvalues[i][1]) - int.parse(aritvalues[i][0]));
      }
      print(aritvalues);
      int rand = 2+rnd.nextInt(5-2);
      Variable a= Variable('a'), b=Variable('b') ;
      Variable c= Variable('c'), d=Variable('d');
      ContextModel cm = ContextModel()
      ..bindVariable(a, Number(rands[0]))
      ..bindVariable(b, Number(rands[1]))
      ..bindVariable(c, Number(rands[2]))
      ..bindVariable(d, Number(rands[3]));
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      List<double> expOpc = [eval,eval+1,eval-1,eval+rand];
      expOpc.shuffle();
      expOpc.shuffle(); 
      print('Expression: $exp');
      print('Evaluated expression: $eval\n  (with context: $cm)');
      if(difficulty==3){
        questionTime = plantilla.timeOpen;
      }else{
        questionTime = plantilla.timeClose;
      }
      questions.add(QuestionModel(
        correctAnswer: eval ,
        options: expOpc,
        question: plantilla.expression,
        time: questionTime,
      ));
    });

    return questions;
  }
}