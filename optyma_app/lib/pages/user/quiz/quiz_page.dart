import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/bloc/authentication/authentication_bloc.dart';
import 'package:optyma_app/bloc/user/user_bloc.dart';
import 'package:optyma_app/cubit/navQuiz/navquiz_cubit.dart';
import 'package:optyma_app/models/quiz_model.dart';
class Quiz extends StatefulWidget{
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {

  QuizModel quiz = new QuizModel();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final QuizModel quizData = ModalRoute.of(context).settings.arguments;
    if (quizData != null ){
      quiz = quizData;
    }
    return Scaffold(
      appBar: AppBar(title: Text(quizData.tema)),
      body: Column (
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(quizData.dificultad.toString()),
          Text(quizData.tema),
        ],
      ),
    ); 
  }
}