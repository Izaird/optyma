
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/bloc/quiz/quiz_bloc.dart';
import 'package:optyma_app/models/quiz_model.dart';
import 'package:optyma_app/repository/plantillas_repository.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math';
class QuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quizData = ModalRoute.of(context).settings.arguments as QuizModel;
    return BlocProvider(
      create: (context) => QuizBloc(plantillasRepository: RepositoryProvider.of<PlantillasRepository>(context))
      ..add(QuizStarted(difficulty: quizData.dificultad, subject: quizData.tema)),
      child: Scaffold(
          appBar: AppBar(title: Text("QuizPage")),
          body: Padding(
            padding: EdgeInsets.all(8.0),
            child: BlocBuilder<QuizBloc, QuizState>(
              builder: (context, state) {
                if(state is QuizInitialized){
                  print(state.plantillas.length);
                  print(state.plantillas[1].expression);
                  Parser p = Parser();
                  Expression exp = p.parse(state.plantillas[3].expression);
                  print(exp.toString());  
                  if(state.plantillas[0].subject==1){
                    List<List<String>> aritvalues=[];
                    List<String> values =state.plantillas[3].values.split(";");
                    List<int> rands = [0,0,0,0];
                    Random rnd = new Random();
                    List<String>opcs = [];
                    print(values);
                    for (int i=0;i<values.length-1;i++){
                      print( values[i].split("-") );
                      aritvalues.add(values[i].split("-"));
                      rands[i] = int.parse(aritvalues[i][0]) + rnd.nextInt(int.parse(aritvalues[i][1]) - int.parse(aritvalues[i][0]));
                    }
                    print("Arit values");
                    print(aritvalues);
                    int rand = 2+rnd.nextInt(5-2);
                    //int r1 = int.parse(aritvalues[0][0]) + rnd.nextInt(int.parse(aritvalues[0][1]) - int.parse(aritvalues[0][0]));
                    print(rands);
                    //int r2 = int.parse(aritvalues[1][0]) + rnd.nextInt(int.parse(aritvalues[1][1]) - int.parse(aritvalues[1][0]));
                    Variable a= Variable('a'), b=Variable('b') ;
                    Variable c= Variable('c'), d=Variable('d');
                    ContextModel cm = ContextModel()
                    ..bindVariable(a, Number(rands[0]))
                    ..bindVariable(b, Number(rands[1]))
                    ..bindVariable(c, Number(rands[2]))
                    ..bindVariable(d, Number(rands[3]));
                    double eval = exp.evaluate(EvaluationType.REAL, cm);
                    List<double> expOpc = [eval,eval+1,eval-1,eval+rand]; 
                    print('Expression: $exp');
                    print('Evaluated expression: $eval\n  (with context: $cm)');
                    expOpc.shuffle();
                    print(expOpc);
                  }
                  return Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(Icons.local_fire_department_outlined),
                          Text(state.streak.toString()),
                          Spacer(),
                          Text(state.score.toString())
                        ],
                      ),
                      Text(state.plantillas[0].sentence),
                      Text(state.plantillas[0].expression),
                    ],
                  );
                }
                else{
                  return Column(
                    children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Icon(Icons.local_fire_department_outlined),
                        //Text(state.streak.toString),
                        Spacer(),
                        //Text(state.score.toString()) 
                      ],
                    ),
                    Text(quizData.tema.toString()),
                    Text(quizData.dificultad.toString()),
                   ],
                  );
                }
                
          },
        ),
      ),
    ),
    );
  }
}


