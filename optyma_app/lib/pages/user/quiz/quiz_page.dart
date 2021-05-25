import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/bloc/authentication/authentication_bloc.dart';
import 'package:optyma_app/bloc/user/user_bloc.dart';
import 'package:optyma_app/bloc/quiz/quiz_bloc.dart';
import 'package:optyma_app/models/quiz_model.dart';
import 'package:optyma_app/repository/plantillas_repository.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  QuizModel quiz = new QuizModel();

  @override
  Widget build(BuildContext context) {
    final QuizModel quizData = ModalRoute.of(context).settings.arguments;
    if (quizData != null) {
      quiz = quizData;
    }
    return BlocProvider(
      create: (context) => QuizBloc(
          plantillasRepository: RepositoryProvider.of<PlantillasRepository>(context), 
          tema: quizData.tema, 
          dificultad: quizData.dificultad),
      child: Scaffold(
        appBar: AppBar(title: Text(quizData.tema)),
        body: BlocBuilder<QuizBloc, QuizState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.flash_on_rounded),
                    Text(state.score.toString()),
                    Text(state.streak.toString()),
                  ],
                ),
                Text(quizData.dificultad.toString()),
                Text(quizData.tema),
              ],
            );
          },
        ),
      ),
    );
  }
}
