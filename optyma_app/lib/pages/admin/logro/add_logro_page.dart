import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/bloc/add_logro/add_logro_bloc.dart';
import 'package:optyma_app/widgets/text_input_widget.dart';


class AddLogroPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar logro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider<AddLogroBloc>(  
          create: (_) => AddLogroBloc(),
          child: AddLogroBody(),
        ),
      ),
    );
  }
}


class AddLogroBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MenuTypesOfLogros(),
        AddLogroForm(),
      ],
    );
  }
}



class MenuTypesOfLogros extends StatefulWidget{
  @override
  _MenuTypesOfLogrosState createState() => _MenuTypesOfLogrosState();
}

class _MenuTypesOfLogrosState extends State<MenuTypesOfLogros> {
  String _typeOfLogro ;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: Text('Tipos de logro'), 
      value: _typeOfLogro,
      items: <DropdownMenuItem>[
        DropdownMenuItem(
          value: 'Niveles',
          child: Text('Niveles'),
          onTap: () {
            BlocProvider.of<AddLogroBloc>(context).add(AddLogroType1Selected());
          },
        ),
        DropdownMenuItem(
          value: 'Racha de respuestas',
          child: Text('Racha de respuestas'),
          onTap: () {
            BlocProvider.of<AddLogroBloc>(context).add(AddLogroType2Selected());
          },
        ),
        DropdownMenuItem(
          value: 'Racha de días',
          child: Text('Racha de días'),
          onTap: () {
            BlocProvider.of<AddLogroBloc>(context).add(AddLogroType3Selected());
          },
        ),
        DropdownMenuItem(
          value: 'Ejercicios realizados',
          child: Text('Ejercicios realizados'),
          onTap: () {
            BlocProvider.of<AddLogroBloc>(context).add(AddLogroType4Selected());
          },
        ),
        DropdownMenuItem(
          value: 'Leaderboard',
          child: Text('Leaderboard'),
          onTap: () {
            BlocProvider.of<AddLogroBloc>(context).add(AddLogroType5Selected());
          },
        ),
      ],
      onChanged: (value) {
        setState(() {
          _typeOfLogro = value;  
        });
      },
    );
  }
}


class AddLogroForm extends StatelessWidget {

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(  
        child: Column(  
          children: [
            TextInput(
              // intialValue: logro.name,
              labelText: 'Ingrese el nombre del logro',
              onSaved: (name) {
                // BlocProvider.of<LogroCubit>(context).nameChanged(name);
              },
            ),
            AddLogroFormType(key: formKey,),
          ],
        ),
      )
    );
  }
}

//Change the form depending on the type of logro that is selected
class AddLogroFormType extends StatelessWidget {

  final GlobalKey<FormState> formKey;

  const AddLogroFormType({Key key, this.formKey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddLogroBloc, AddLogroState>(
      builder: (context, state) {
        //Niveles
        if(state is AddLogroType1InPRogress){
          return Column(
            children: [
              DifficultyDropDown(),
              SubjectDropDown(),
              ElevatedButton(
                child: Text('Agregar logro'),
                onPressed: (){
                  //Don't do anything until everything is validated
                  if(!formKey.currentState.validate()) return;
                  
                  formKey.currentState.save();
                }, 
              ),
            ],
          );
        }
        //Racha de respuestas
        if(state is AddLogroType2InPRogress){
          return NumberOfAnswersDropDown();
        }
        //Racha de dias
        if(state is AddLogroType3InPRogress){
          return NumberOfDaysDropDown();
        }
        //Ejercicios realizados
        if(state is AddLogroType4InPRogress){
          return NumberOfExercisesDropDown();
        }
        if(state is AddLogroType5InPRogress){
          return Column(
            children: [
              DifficultyDropDown(),
              SubjectDropDown(),
            ],
          );
        }
        return Container();
      },
    );
  }
}

class DifficultyDropDown extends StatefulWidget {

  @override
  _DifficultyDropDownState createState() => _DifficultyDropDownState();
}

class _DifficultyDropDownState extends State<DifficultyDropDown> {

  String _difficulty; 

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: Text('Dificultad'),  
      value: _difficulty,
      items: [
        DropdownMenuItem(
          value: 1,
          child: Text('Fácil'),
        ),
        DropdownMenuItem(
          value: 2,
          child: Text('Medio'),
        ),
        DropdownMenuItem(
          value: 3,
          child: Text('Difícil'),
        ),
      ],
      onChanged: (value) {
        setState(() {
          
        });
      },
      validator: (value) {
        if(value=!null){
          return null;
        }
        else{
          return 'Necesitas escoger una dificultad';
        }
      },
    );
  }
}

class SubjectDropDown extends StatefulWidget {

  @override
  _SubjectDropDownState createState() => _SubjectDropDownState();
}

class _SubjectDropDownState extends State<SubjectDropDown> {

  String _subject; 

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: Text('Tema'),  
      value: _subject,
      items: [
        DropdownMenuItem(
          value: 1,
          child: Text('Aritmética'),
        ),
        DropdownMenuItem(
          value: 2,
          child: Text('Álgebra'),
        ),
        DropdownMenuItem(
          value: 3,
          child: Text('Diferencial'),
        ),
        DropdownMenuItem(
          value: 4,
          child: Text('Optimización'),
        ),
      ],
      onChanged: (value) {
        setState(() {
          
        });
      },
      validator: (value) {
        if(value=!null){
          return null;
        }
        else{
          return 'Necesitas escoger un tema';
        }
      },
    );
  }
}


class NumberOfAnswersDropDown extends StatefulWidget {
  NumberOfAnswersDropDown({Key key}) : super(key: key);

  @override
  _NumberOfAnswersDropDownState createState() => _NumberOfAnswersDropDownState();
}
class _NumberOfAnswersDropDownState extends State<NumberOfAnswersDropDown> {
  int _answers;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: Text('Número de respuestas'),  
      value: _answers,
      items: [
        DropdownMenuItem(
          value: 1,
          child: Text('1'),
        ),
        DropdownMenuItem(
          value: 2,
          child: Text('2'),
        ),
        DropdownMenuItem(
          value: 3,
          child: Text('3'),
        ),
        DropdownMenuItem(
          value: 4,
          child: Text('4'),
        ),
      ],
      onChanged: (value) {
        setState(() {
          
        });
      }
    );
  }
}

class NumberOfExercisesDropDown extends StatefulWidget {
  NumberOfExercisesDropDown({Key key}) : super(key: key);

  @override
  _NumberOfExcercisesDropDownState createState() => _NumberOfExcercisesDropDownState();
}
class _NumberOfExcercisesDropDownState extends State<NumberOfExercisesDropDown> {
  int _exercises;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: Text('Número de ejercicios'),  
      value: _exercises,
      items: [
        DropdownMenuItem(
          value: 1,
          child: Text('1'),
        ),
        DropdownMenuItem(
          value: 2,
          child: Text('2'),
        ),
        DropdownMenuItem(
          value: 3,
          child: Text('3'),
        ),
        DropdownMenuItem(
          value: 4,
          child: Text('4'),
        ),
      ],
      onChanged: (value) {
        setState(() {
          
        });
      }
    );
  }
}


class NumberOfDaysDropDown extends StatefulWidget {
  NumberOfDaysDropDown({Key key}) : super(key: key);

  @override
  _NumberOfDaysDropDownState createState() => _NumberOfDaysDropDownState();
}
class _NumberOfDaysDropDownState extends State<NumberOfDaysDropDown> {
  int _days;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: Text('Número de días'),  
      value: _days,
      items: [
        DropdownMenuItem(
          value: 1,
          child: Text('1'),
        ),
        DropdownMenuItem(
          value: 2,
          child: Text('2'),
        ),
        DropdownMenuItem(
          value: 3,
          child: Text('3'),
        ),
        DropdownMenuItem(
          value: 4,
          child: Text('4'),
        ),
      ],
      onChanged: (value) {
        setState(() {
          
        });
      }
    );
  }
}