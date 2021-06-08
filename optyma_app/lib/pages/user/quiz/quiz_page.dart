
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/bloc/quiz/quiz_bloc.dart';
import 'package:optyma_app/models/quiz_model.dart';

import 'package:optyma_app/repository/questions_repository.dart';
class QuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quizData = ModalRoute.of(context).settings.arguments as QuizModel;
    return BlocProvider(
      create: (context) => QuizBloc(questionsRepository: RepositoryProvider.of<QuestionsRepository>(context))
      ..add(QuizStarted(difficulty: quizData.dificultad, subject: quizData.tema)),
      child: Scaffold(
          appBar: AppBar(title: Text("QuizPage")),
          body: Padding(
            padding: EdgeInsets.all(8.0),
            child: BlocBuilder<QuizBloc, QuizState>(
              builder: (context, state) {
                if(state is QuizInitialized){
                  state.questions.forEach((element) { 
                    print(element.options);
                  });
                }
                  return Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(Icons.local_fire_department_outlined),
                          // Text(state.streak.toString()),
                          Spacer(),
                          // Text(state.score.toString())
                        ],
                      ),
                      // Text(state.plantillas[0].sentence),
                      // Text(state.plantillas[0].expression),
                    ],
                  );
                }
        ),
      ),
    ),
    );
  }
}


