import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/bloc/add_logro/add_logro_bloc.dart';
import 'package:optyma_app/repository/logros_repository.dart';
import 'package:optyma_app/utils/constants.dart';
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
          create: (_) => AddLogroBloc(
              logrosRepository:RepositoryProvider.of<LogrosRepository>(context)),
          child: AddLogroBody(),
        ),
      ),
    );
  }
}

class AddLogroBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AddLogroBloc, AddLogroState>(
      listener: (context, state) {
        //Submission was a failure
        if(state.status == FormStatus.submissionFailure){
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(content: Text('Ocurrio un error al agregar el logro')),
          );
        }
        //Submission was a success
        //FIXME: For some reason the pop(context) is popping up 2 screens insted of 1
        //?Should I use a bloc for the navigation ? 
        if(state.status == FormStatus.submissionSuccess){
          Navigator.pop(context);
        }
      },
      child: Column(
        children: [
          MenuTypesOfLogros(),
          AddLogroForm(),
        ],
      ),
    );
  }
}

class MenuTypesOfLogros extends StatefulWidget {
  @override
  _MenuTypesOfLogrosState createState() => _MenuTypesOfLogrosState();
}

class _MenuTypesOfLogrosState extends State<MenuTypesOfLogros> {
  String _typeOfLogro;
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
                  BlocProvider.of<AddLogroBloc>(context)
                      .add(AddLogroNameChanged(name));
                },
              ),
              AddLogroFormType(),
              BlocBuilder<AddLogroBloc, AddLogroState>(
                builder: (context, state) {
                  if (state.logroType != null) {
                    return ElevatedButton(
                        onPressed: () {
                          if (!formKey.currentState.validate()) return;

                          formKey.currentState.save();
                          BlocProvider.of<AddLogroBloc>(context)
                              .add(AddLogroFormValidated());
                          BlocProvider.of<AddLogroBloc>(context)
                              .add(AddLogroFormSubmitted());
                        },
                        child: Text('Agregar logro'));
                  }
                  return Container();
                },
              )
            ],
          ),
        ));
  }
}

//Change the form depending on the type of logro that is selected
class AddLogroFormType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddLogroBloc, AddLogroState>(
      builder: (context, state) {
        //Niveles
        if (state.logroType == LogroType.nive) {
          return Column(
            children: [
              DifficultyDropDown(),
              SubjectDropDown(),
            ],
          );
        }
        //Racha de respuestas
        if (state.logroType == LogroType.rRes) {
          return NumberOfAnswersDropDown();
        }
        //Racha de dias
        if (state.logroType == LogroType.rDia) {
          return NumberOfDaysDropDown();
        }
        //Ejercicios realizados
        if (state.logroType == LogroType.eRes) {
          return NumberOfExercisesDropDown();
        }
        if (state.logroType == LogroType.lead) {
          return Column(
            children: [
              SubjectDropDown(),
            ],
          );
        }
        return Container();
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
        setState(() {});
      },
      onSaved: (subject) {
        BlocProvider.of<AddLogroBloc>(context)
            .add(AddLogroSubjectChanged(subject));
      },
      validator: (value) {
        if (value != null) {
          return null;
        } else {
          return 'Necesitas escoger un tema';
        }
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
        setState(() {});
      },
      onSaved: (difficulty) {
        BlocProvider.of<AddLogroBloc>(context)
            .add(AddLogroDifficultyChanged(difficulty));
      },
      validator: (value) {
        if (value != null) {
          return null;
        } else {
          return 'Necesitas escoger una dificultad';
        }
      },
    );
  }
}

class NumberOfAnswersDropDown extends StatefulWidget {
  NumberOfAnswersDropDown({Key key}) : super(key: key);

  @override
  _NumberOfAnswersDropDownState createState() =>
      _NumberOfAnswersDropDownState();
}

class _NumberOfAnswersDropDownState extends State<NumberOfAnswersDropDown> {
  List<int> _numberOfAnswers = [1, 2, 3, 4, 5];
  int _answers;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: Text('Número de respuestas'),
      value: _answers,
      items: _numberOfAnswers.map((numberOfAnswers) {
        return DropdownMenuItem(
          child: Text(numberOfAnswers.toString()),
          value: numberOfAnswers,
        );
      }).toList(),
      onChanged: (value) {
        setState(() {});
      },
      onSaved: (numberOfAnswers) {
        BlocProvider.of<AddLogroBloc>(context)
            .add(AddLogroNumberOfAnswersChanged(numberOfAnswers));
      },
      validator: (value) {
        if (value != null) {
          return null;
        } else {
          return 'Escoge el número de respuestas';
        }
      },
    );
  }
}

class NumberOfExercisesDropDown extends StatefulWidget {
  NumberOfExercisesDropDown({Key key}) : super(key: key);

  @override
  _NumberOfExcercisesDropDownState createState() =>
      _NumberOfExcercisesDropDownState();
}

class _NumberOfExcercisesDropDownState extends State<NumberOfExercisesDropDown> {

  List<int> _numberOfExercises = [1, 2, 4, 5];
  int _exercises;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: Text('Número de ejercicios'),
      value: _exercises,
      items: _numberOfExercises.map((numberOfExercises) {
        return DropdownMenuItem(
          child: Text(numberOfExercises.toString()),
          value: numberOfExercises,
        );
      }).toList(),
      onChanged: (value) {
        setState(() {});
      },
      onSaved: (numberOfExercises) {
        BlocProvider.of<AddLogroBloc>(context)
            .add(AddLogroNumberOfExercisesChanged(numberOfExercises));
      },
      validator: (value) {
        if (value != null) {
          return null;
        } else {
          return 'Escoge el número de ejercicios';
        }
      },
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
  List<int> _numberOfDays = [4, 5, 6, 9];
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: Text('Número de días'),
      value: _days,
      items: _numberOfDays.map((numberOfDays) {
        return DropdownMenuItem(
          child: Text(numberOfDays.toString()),
          value: numberOfDays,
        );
      }).toList(),
      onChanged: (value) {
        setState(() {});
      },
      onSaved: (numberOfDays) {
        BlocProvider.of<AddLogroBloc>(context)
            .add(AddLogroNumberOfDaysChanged(numberOfDays));
      },
      validator: (value) {
        if (value != null) {
          return null;
        } else {
          return 'Escoge el número de días';
        }
      },
    );
  }
}
