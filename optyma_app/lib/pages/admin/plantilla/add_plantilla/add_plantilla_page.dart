import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/bloc/add_plantilla/add_plantilla_bloc.dart';
import 'package:optyma_app/models/plantilla_model.dart';
import 'package:optyma_app/repository/authentication_repository.dart';
import 'package:optyma_app/repository/plantillas_repository.dart';
import 'package:optyma_app/utils/constants.dart';
import 'package:optyma_app/widgets/dd_form_field_str_widget.dart';
import 'package:optyma_app/widgets/text_input_widget.dart';

class AddPlantillaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar plantilla'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider<AddPlantillaBloc>(
          create: (_) => AddPlantillaBloc(
              plantillasRepository:RepositoryProvider.of<PlantillasRepository>(context),
              authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context)),
          child: SingleChildScrollView(
            child: AddPlantillaBody()
          ),
        ),
      ),
    );
  }
}

class AddPlantillaBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  final plantilla = ModalRoute.of(context).settings.arguments as PlantillaModel;

  if(plantilla?.subject != null){
    switch (plantilla.subject) {
      case 1:
        BlocProvider.of<AddPlantillaBloc>(context).add(AddPlantillaType1Selected());
        break;
      case 2:
        BlocProvider.of<AddPlantillaBloc>(context).add(AddPlantillaType2Selected());
        break;
      case 3:
        BlocProvider.of<AddPlantillaBloc>(context).add(AddPlantillaType3Selected());
        break;
      case 4:
        BlocProvider.of<AddPlantillaBloc>(context).add(AddPlantillaType4Selected());
        break;
      default:
    }
  }
    return BlocListener<AddPlantillaBloc, AddPlantillaState>(
      listener: (context, state) {
        //Submission was a failure
        if(state.status == FormStatus.submissionFailure){
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(content: Text('Ocurrio un error al agregar el plantilla')),
          );
        }
        //Submission was a success
        if(state.status == FormStatus.submissionSuccess){
          Navigator.pop(context);
        }
      },
      child: Column(
        children: [
          MenuTypesOfPlantillas(typeOfPlantillaEdit: plantilla?.subject),
          AddPlantillaForm(idPlantilla: plantilla?.id),
        ],
      ),
    );
  }
}

class MenuTypesOfPlantillas extends StatefulWidget {
  final int typeOfPlantillaEdit;

  const MenuTypesOfPlantillas({
    this.typeOfPlantillaEdit,
  });
  @override
  _MenuTypesOfPlantillasState createState() => _MenuTypesOfPlantillasState();
}

class _MenuTypesOfPlantillasState extends State<MenuTypesOfPlantillas> {
  int _typeOfPlantilla;

  @override
  void initState() {
    _typeOfPlantilla = widget.typeOfPlantillaEdit;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _typeOfPlantilla = widget.typeOfPlantillaEdit; 
    return DropdownButton(
      hint: Text('Tipos de plantilla'),
      value: _typeOfPlantilla,
      items: <DropdownMenuItem>[
        DropdownMenuItem(
          value: 1,
          child: Text('Aritmética'),
          onTap: () => BlocProvider.of<AddPlantillaBloc>(context).add(AddPlantillaType1Selected()),
        ),
        DropdownMenuItem(
          value: 2,
          child: Text('Algebra'),
          onTap: () => BlocProvider.of<AddPlantillaBloc>(context).add(AddPlantillaType2Selected()),
        ),
        DropdownMenuItem(
          value: 3,
          child: Text('Cálculo Diferencial'),
          onTap: () => BlocProvider.of<AddPlantillaBloc>(context).add(AddPlantillaType3Selected()),
        ),
        DropdownMenuItem(
          value: 4,
          child: Text('Optimización'),
          onTap: () => BlocProvider.of<AddPlantillaBloc>(context).add(AddPlantillaType4Selected()),
        ),
      ],
      onChanged: (value) {
        setState(() {
          _typeOfPlantilla = value;
        });
      },
    );
  }
}

class AddPlantillaForm extends StatelessWidget {
  final String idPlantilla;

  final formKey = GlobalKey<FormState>();

  AddPlantillaForm({this.idPlantilla});
  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: SingleChildScrollView(
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              AddLogroBlocBuilder(),
              BlocBuilder<AddPlantillaBloc, AddPlantillaState>(
                builder: (context, state) {
                  if (state.subject != null) {
                    return ElevatedButton(
                        onPressed: () {
                          if (!formKey.currentState.validate()) return;
                          formKey.currentState.save();
                          BlocProvider.of<AddPlantillaBloc>(context).add(AddPlantillaFormValidated());
                          if(idPlantilla != null){
                            BlocProvider.of<AddPlantillaBloc>(context).add(UpdatePlantillaFormSubmitted(idPlantilla));
                          }else{
                            BlocProvider.of<AddPlantillaBloc>(context).add(AddPlantillaFormSubmitted());
                          }
                        },
                        child: Text('Agregar plantilla'));
                  }
                  return Container();
                },
              )
            ],
          ),
        ));
  }
}


//Change the form depending on the type of plantilla that is selected
class AddLogroBlocBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  final plantilla = ModalRoute.of(context).settings.arguments as PlantillaModel;
    return BlocBuilder<AddPlantillaBloc, AddPlantillaState>(
      builder: (context, state) {
        //Aritmetica
        if (state.subject == 1) {
          return Column(
            children: [
              PlantillaSentence(plantillaSentenceEdit: plantilla?.sentence),
              PlantillaExpression(plantillaExpressionEdit: plantilla?.expression),
              PlantillaValues(plantillaValuesEdit: plantilla?.expression),
              DifficultyDropDown(plantillaDifficultyEdit: plantilla?.difficulty),
              PlantillaTimeClose(plantillaTimeClose: plantilla?.timeClose),
              PlantillaTimeOpen(plantillaTimeOpen: plantilla?.timeOpen),
            ],
          );
        }
        //Algebra
        if (state.subject == 2) {
          return Column(
            children: [PlantillaSentence(plantillaSentenceEdit: plantilla?.sentence),
              PlantillaExpression(plantillaExpressionEdit: plantilla?.expression),
              DifficultyDropDown(plantillaDifficultyEdit: plantilla?.difficulty),
              PlantillaTimeClose(plantillaTimeClose: plantilla?.timeClose),
              PlantillaTimeOpen(plantillaTimeOpen: plantilla?.timeOpen),
            ],
          );
        }
        //Diferencial
        if (state.subject == 3) {
          return Column(
            children: [PlantillaSentence(plantillaSentenceEdit: plantilla?.sentence),
              PlantillaExpression(plantillaExpressionEdit: plantilla?.expression),
              DifficultyDropDown(plantillaDifficultyEdit: plantilla?.difficulty),
              PlantillaTimeClose(plantillaTimeClose: plantilla?.timeClose), 
              PlantillaTimeOpen(plantillaTimeOpen: plantilla?.timeOpen),           
            ],
          );
        }
        //Optimizacion
        if (state.subject == 4) {
          return Column(
            children: [PlantillaSentence(plantillaSentenceEdit: plantilla?.sentence),
              PlantillaExpression(plantillaExpressionEdit: plantilla?.expression),
              DifficultyDropDown(plantillaDifficultyEdit: plantilla?.difficulty),
              PlantillaTimeClose(plantillaTimeClose: plantilla?.timeClose),
              PlantillaTimeOpen(plantillaTimeOpen: plantilla?.timeOpen),
            ],
          );
        }
        return Container();
      },
    );
  }
}


class PlantillaSentence extends StatelessWidget {
  final String plantillaSentenceEdit;

  const PlantillaSentence({this.plantillaSentenceEdit});
  @override
  Widget build(BuildContext context) {
    return TextInput(
      intialValue: plantillaSentenceEdit,
      labelText: 'Ingrese la sentencia de la plantilla',
      onSaved: (sentence) => BlocProvider.of<AddPlantillaBloc>(context).add(AddPlantillaSentenceChanged(sentence)),
    );
  }
}
class PlantillaValues extends StatelessWidget {
  final String plantillaValuesEdit;

  const PlantillaValues({this.plantillaValuesEdit});
  @override
  Widget build(BuildContext context) {
    return TextValuesInput(
      intialValue: plantillaValuesEdit,
      labelText: 'Ingrese los valores de la plantilla',
      //onSaved: (sentence) => BlocProvider.of<AddPlantillaBloc>(context).add(AddPlantillaValuesChanged(sentence)),
    );
  }
}

class PlantillaExpression extends StatelessWidget {
  final String plantillaExpressionEdit;

  const PlantillaExpression({this.plantillaExpressionEdit});
  @override
  Widget build(BuildContext context) {
    return TextPlantillaInput(
      intialValue: plantillaExpressionEdit,
      labelText: 'Ingrese la expresión de la plantilla',
      onSaved: (expression) => BlocProvider.of<AddPlantillaBloc>(context).add(AddPlantillaExpressionChanged(expression)),
    );
  }
}

class PlantillaTimeClose extends StatelessWidget {
  final int plantillaTimeClose;

  const PlantillaTimeClose({this.plantillaTimeClose});
  @override
  Widget build(BuildContext context) {
    return TextTimeInput(
      intialValue: plantillaTimeClose?.toString() ,
      labelText: 'Ingrese el tiempo de pregunta cerrada',
      onSaved: (timeClose) => BlocProvider.of<AddPlantillaBloc>(context).add(AddPlantillaTimeCloseChanged(int.parse(timeClose))),
    );
  }
}

class PlantillaTimeOpen extends StatelessWidget {
  final int plantillaTimeOpen;

  const PlantillaTimeOpen({this.plantillaTimeOpen});
  @override
  Widget build(BuildContext context) { return TextTimeInput(
      intialValue: plantillaTimeOpen?.toString(),
      labelText: 'Ingrese el tiempo de pregunta abierta',
      onSaved: (timeOpen) => BlocProvider.of<AddPlantillaBloc>(context).add(AddPlantillaTimeOpenChanged(int.parse(timeOpen))),
    );
  }
}


class DifficultyDropDown extends StatelessWidget {

  final int plantillaDifficultyEdit;

  const DifficultyDropDown({this.plantillaDifficultyEdit});
  @override
  Widget build(BuildContext context) {
    return DropdownStrToIntWidget(
      items: ['Fácil', 'Medio', 'Difícil'],
      intialValue: (plantillaDifficultyEdit != null) ? plantillaDifficultyEdit -1 : null,
      hint: 'Dificultad',
      onSaved: (difficulty) => BlocProvider.of<AddPlantillaBloc>(context).add(AddPlantillaDifficultyChanged(difficulty+1)),
      validatorErrorMessage: 'Necesitas escoger una dificultad',
    );
  }
}