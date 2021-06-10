
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
                    print(element.correctAnswer);
                  });
                  return Column(
                    children: <Widget>[
                      TopBar(),
                      
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          children: [
                            Text(state.questions[0].question,
                            style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black),
                            ),
                            Option(option: state.questions[0].options[0]),
                            Option(option: state.questions[0].options[1]),
                            Option(option: state.questions[0].options[2]),
                            Option(option: state.questions[0].options[3])
                          ],
                        ),
                      ),
                    ],
                  );
                }
                  return Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(Icons.local_fire_department_outlined),
                          Text("0"),
                          Spacer(),
                          Text("0")
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          children: [
                            Text("sample",
                            style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black),
                            ),
                            Option(),
                            Option(),
                            Option(),
                            Option()
                          ],
                        ),
                      ),
                    ],
                  );
                }
        ),
      ),
    ),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Icon(Icons.local_fire_department_outlined),
        Text("0"),
        Spacer(),
        Text("0")
      ],
    );
  }
}

class Option extends StatelessWidget {
  const Option({
    Key key,
    this.option
  }) : super(key: key);
final double option;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$option",
          style:TextStyle(fontSize: 16),
          ),
          Container(height: 26 ,
          width: 26,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.black45) 
            ),
          ),
        ],
      ),
    );
  }
}


