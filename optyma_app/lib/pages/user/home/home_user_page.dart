import 'package:flutter/material.dart';
import 'package:optyma_app/models/quiz_model.dart';
import 'package:optyma_app/widgets/dd_form_field_str_widget.dart';
import 'package:optyma_app/widgets/menu_user.dart';

class HomeUserPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final List<String> difficultys  = ['1','2','3'];
  final List<String> subjects     = ["Aritmética", "Algebra", "Diferencial", "Optimización"];
  final QuizModel quizData = new QuizModel();   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User'),
      ),
      drawer: MenuUser(),
      body:  Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
              DropdownStrToIntWidget(
                hint: 'Tema',
                items: subjects,
                intialValue: 0,
                validatorErrorMessage: 'Se tiene que escoger un tema',
                onSaved: (tema){
                  quizData.tema=tema+1;
                }
              ),
              DropdownStrToIntWidget(
                hint: 'Dificultad',
                items: difficultys,
                intialValue: 0,
                validatorErrorMessage: 'Se tiene que escoger una dificultad',
                onSaved: (difficulty){
                  quizData.dificultad=(difficulty+1);
                }
              ),
              _submitButton(context),
          ] ,
        ),
      )
    );
  }

    Widget _submitButton(BuildContext context) {
        return ElevatedButton(
            child: Text('Comenzar'),
            onPressed: (){
             formKey.currentState.save(); 
             return Navigator.pushNamed(context, 'quiz', arguments: quizData);
            },  
          );
  }
}
