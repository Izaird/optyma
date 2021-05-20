import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/bloc/authentication/authentication_bloc.dart';
import 'package:optyma_app/bloc/user/user_bloc.dart';
import 'package:optyma_app/widgets/dropdown_widget.dart';
import 'package:optyma_app/models/quiz_model.dart';

class HomeUserPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final List<String> difficultys  = ['1','2','3'];
  final List<String> subjects     = ["Aritmética", "Algebra", "Diferencial", "Optimización"];
  final QuizModel quizData = new QuizModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
              BlocProvider.of<UserBloc>(context).add(UserLoggedOut());
            },
          )
        ],
      ),
      body:  Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Tema"),
                    DropDownWidget(items: subjects,
                      defaultText: "Aritmética",
                      intialValue: "Aritmética",
                      validator: (subject) => subject == null ? 'Se tiene que escoger un tema' : null,
                      onSaved: (tema){
                      quizData.tema=tema;
                    }),
                    Text("Dificultad"),
                    DropDownWidget(items: difficultys,
                      defaultText: "1",
                      intialValue: "1",
                      validator: (difficulty) => difficulty == null ? 'Se tiene que escoger una dificultad' : null,
                      onSaved: (difficulty){
                      quizData.dificultad=(int.parse(difficulty));
                    }),
                    _submitButton(context),
                  ],
                ),
          )
      );
  }

    Widget _submitButton(BuildContext context) {
        return ElevatedButton(
            child: Text('Jugar'),
            onPressed: (){
             formKey.currentState.save(); 
             return Navigator.pushNamed(context, 'quiz', arguments: quizData);
            },  
          );
  }
}
