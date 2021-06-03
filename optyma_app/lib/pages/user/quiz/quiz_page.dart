
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
                  Expression exp = p.parse(state.plantillas[1].expression);
                  print(exp.toString());  
                  if(state.plantillas[0].subject==1){
                    List<String> values =state.plantillas[1].values.split(";");
                    print(values);
                    List<String> valueA = values[0].split("-");
                    print(valueA);
                    List<String> valueB = values[1].split("-");
                    print(valueB);
                    Random rnd = new Random();
                    int r1 = int.parse(valueA[0]) + rnd.nextInt(int.parse(valueA[1]) - int.parse(valueA[0]));
                    print(r1);
                    int r2 = int.parse(valueB[0]) + rnd.nextInt(int.parse(valueB[1]) - int.parse(valueB[0]));
                    print(r2);
                    Variable a= Variable('a'), b=Variable('b');
                    ContextModel cm = ContextModel()
                    ..bindVariable(a, Number(r1))
                    ..bindVariable(b, Number(r2));
                    double eval = exp.evaluate(EvaluationType.REAL, cm);

                    print('Expression: $exp');
                    print('Evaluated expression: $eval\n  (with context: $cm)');
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


