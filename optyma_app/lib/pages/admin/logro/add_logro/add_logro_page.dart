import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/bloc/add_logro/add_logro_bloc.dart';
import 'package:optyma_app/models/logro_model.dart';
import 'package:optyma_app/repository/logros_repository.dart';
import 'package:optyma_app/utils/constants.dart';
import 'package:optyma_app/widgets/dd_form_field_int_widget.dart';
import 'package:optyma_app/widgets/dd_form_field_str_widget.dart';
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
  final logro = ModalRoute.of(context).settings.arguments as LogroModel;

  if(logro?.type != null){
    switch (logro.type) {
      case 1:
        BlocProvider.of<AddLogroBloc>(context).add(AddLogroType1Selected());
        break;
      case 2:
        BlocProvider.of<AddLogroBloc>(context).add(AddLogroType2Selected());
        break;
      case 3:
        BlocProvider.of<AddLogroBloc>(context).add(AddLogroType3Selected());
        break;
      case 4:
        BlocProvider.of<AddLogroBloc>(context).add(AddLogroType4Selected());
        break;
      case 5:
        BlocProvider.of<AddLogroBloc>(context).add(AddLogroType5Selected());
        break;
      default:
    }
  }
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
        if(state.status == FormStatus.submissionSuccess){
          Navigator.pop(context);
        }
      },
      child: Column(
        children: [
          MenuTypesOfLogros(typeOfLogroEdit: logro?.type),
          AddLogroForm(idLogro: logro?.id),
        ],
      ),
    );
  }
}

class MenuTypesOfLogros extends StatefulWidget {
  final int typeOfLogroEdit;

  const MenuTypesOfLogros({
    this.typeOfLogroEdit,
  });
  @override
  _MenuTypesOfLogrosState createState() => _MenuTypesOfLogrosState();
}

class _MenuTypesOfLogrosState extends State<MenuTypesOfLogros> {
  int _typeOfLogro;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: Text('Tipos de logro'),
      value: widget.typeOfLogroEdit ?? _typeOfLogro,
      items: <DropdownMenuItem>[
        DropdownMenuItem(
          value: 1,
          child: Text('Niveles'),
          onTap: () => BlocProvider.of<AddLogroBloc>(context).add(AddLogroType1Selected()),
        ),
        DropdownMenuItem(
          value: 2,
          child: Text('Racha de respuestas'),
          onTap: () => BlocProvider.of<AddLogroBloc>(context).add(AddLogroType2Selected()),
        ),
        DropdownMenuItem(
          value: 3,
          child: Text('Racha de días'),
          onTap: () => BlocProvider.of<AddLogroBloc>(context).add(AddLogroType3Selected()),
        ),
        DropdownMenuItem(
          value: 4,
          child: Text('Ejercicios realizados'),
          onTap: () => BlocProvider.of<AddLogroBloc>(context).add(AddLogroType4Selected()),
        ),
        DropdownMenuItem(
          value: 5,
          child: Text('Leaderboard'),
          onTap: () => BlocProvider.of<AddLogroBloc>(context).add(AddLogroType5Selected()),
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
  final String idLogro;

  final formKey = GlobalKey<FormState>();

  AddLogroForm({this.idLogro});
  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AddLogroBlocBuilder(),
              BlocBuilder<AddLogroBloc, AddLogroState>(
                builder: (context, state) {
                  if (state.logroType != null) {
                    return ElevatedButton(
                        onPressed: () {
                          if (!formKey.currentState.validate()) return;
                          formKey.currentState.save();
                          BlocProvider.of<AddLogroBloc>(context).add(AddLogroFormValidated());
                          if(idLogro != null){
                            BlocProvider.of<AddLogroBloc>(context).add(UpdateLogroFormSubmitted(idLogro));
                          }else{
                            BlocProvider.of<AddLogroBloc>(context).add(AddLogroFormSubmitted());
                          }
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
class AddLogroBlocBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  final logro = ModalRoute.of(context).settings.arguments as LogroModel;
    return BlocBuilder<AddLogroBloc, AddLogroState>(
      builder: (context, state) {
        //Niveles
        if (state.logroType == LogroType.nive) {
          return Column(
            children: [
              LogroName(logroNameEdit: logro?.name),
              DifficultyDropDown(logroDifficultyEdit: logro?.difficulty),
              SubjectDropDown(logroSubjectEdit: logro?.subject),
            ],
          );
        }
        //Racha de respuestas
        if (state.logroType == LogroType.rRes) {
          return Column(
            children: [
              LogroName(logroNameEdit: logro?.name),
              NumberOfAnswersDropDown(logroAnswersEdit: logro?.numberOfAnswers),
            ],
          );
        }
        //Racha de dias
        if (state.logroType == LogroType.rDia) {
          return Column(
            children: [
              LogroName(logroNameEdit: logro?.name),
              NumberOfDaysDropDown(logroDaysEdit: logro?.numberOfDays),
            ],
          );
        }
        //Ejercicios realizados
        if (state.logroType == LogroType.eRes) {
          return Column(
            children: [
              LogroName(logroNameEdit: logro?.name),
              NumberOfExercisesDropDown(logroExercisesEdit: logro?.numberOfExercises),
            ],
          );
        }
        if (state.logroType == LogroType.lead) {
          return Column(
            children: [
              LogroName(logroNameEdit: logro?.name),
              SubjectDropDown(logroSubjectEdit: logro?.subject),
            ],
          );
        }
        return Container();
      },
    );
  }
}


class LogroName extends StatelessWidget {
  final String logroNameEdit;

  const LogroName({this.logroNameEdit});
  @override
  Widget build(BuildContext context) {
    return TextInput(
      intialValue: logroNameEdit,
      labelText: 'Ingrese el nombre del logro',
      onSaved: (name) => BlocProvider.of<AddLogroBloc>(context).add(AddLogroNameChanged(name)),
    );
  }
}

class SubjectDropDown extends StatelessWidget {

  final int logroSubjectEdit;

  const SubjectDropDown({this.logroSubjectEdit});
  @override
  Widget build(BuildContext context) {
    return DropdownStrToIntWidget(
      items: ['Cualquier tema', 'Aritmética', 'Álgebra', 'Diferencial', 'Optimización'],
      intialValue: logroSubjectEdit,
      hint: 'Tema',
      //Counts starts at 0 so we need 
      onSaved: (subject) => BlocProvider.of<AddLogroBloc>(context).add(AddLogroSubjectChanged(subject)),
    );
  }
}

class DifficultyDropDown extends StatelessWidget {

  final int logroDifficultyEdit;

  const DifficultyDropDown({this.logroDifficultyEdit});
  @override
  Widget build(BuildContext context) {
    return DropdownStrToIntWidget(
      items: ['Cualquier dificultad', 'Fácil', 'Medio', 'Difícil'],
      intialValue: logroDifficultyEdit,
      hint: 'Dificultad',
      onSaved: (difficulty) => BlocProvider.of<AddLogroBloc>(context).add(AddLogroDifficultyChanged(difficulty+1)),
      validatorErrorMessage: 'Necesitas escoger una dificultad',
    );
  }
}

class NumberOfAnswersDropDown extends StatelessWidget {

  final int logroAnswersEdit;

  const NumberOfAnswersDropDown({this.logroAnswersEdit});
  @override
  Widget build(BuildContext context) {
    return DropdownIntToIntWidget(
      items: [1,2,3,4,5],
      intialValue: logroAnswersEdit,
      hint: 'Número de respuestas',
      onSaved: (numberOfAnswers) => BlocProvider.of<AddLogroBloc>(context).add(AddLogroNumberOfAnswersChanged(numberOfAnswers)),
      validatorErrorMessage: 'Escoge el numero de respuestas',
    );
  }
}

class NumberOfExercisesDropDown extends StatelessWidget {

  final int logroExercisesEdit;

  const NumberOfExercisesDropDown({this.logroExercisesEdit});
  @override
  Widget build(BuildContext context) {
    return DropdownIntToIntWidget(
      items: [1,2,3,4,5],
      intialValue: logroExercisesEdit,
      hint: 'Número de ejercicios',
      onSaved: (numberOfExercises) => BlocProvider.of<AddLogroBloc>(context).add(AddLogroNumberOfExercisesChanged(numberOfExercises)),
      validatorErrorMessage:'Necesitas escoger el número de ejercicios',
    );
  }
}

class NumberOfDaysDropDown extends StatelessWidget {

  final int logroDaysEdit;

  const NumberOfDaysDropDown({this.logroDaysEdit});
  @override
  Widget build(BuildContext context) {
    return DropdownIntToIntWidget(
      items: [1,2,3,4,5],
      intialValue: logroDaysEdit,
      hint: 'Número de días',
      onSaved: (numberOfDays) => BlocProvider.of<AddLogroBloc>(context).add(AddLogroNumberOfDaysChanged(numberOfDays)),
      validatorErrorMessage:'Escoge el número de días',
    );
  }
}
