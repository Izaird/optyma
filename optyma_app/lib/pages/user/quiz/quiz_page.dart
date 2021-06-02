import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/bloc/quiz/quiz_bloc.dart';
import 'package:optyma_app/models/quiz_model.dart';
import 'package:optyma_app/repository/plantillas_repository.dart';

class QuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quizData = ModalRoute.of(context).settings.arguments as QuizModel;
    return BlocProvider(
      create: (context) => QuizBloc(plantillasRepository: RepositoryProvider.of<PlantillasRepository>(context)),
      child: Scaffold(
          appBar: AppBar(title: Text("QuizPage")),
          body: Padding(
            padding: EdgeInsets.all(8.0),
            child: BlocBuilder<QuizBloc, QuizState>(
              builder: (context, state) {
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
                Text(quizData.tema.toString()),
                Text(quizData.dificultad.toString()),
              ],
            );
          },
        ),
      ),
    ),
    );
  }
}


