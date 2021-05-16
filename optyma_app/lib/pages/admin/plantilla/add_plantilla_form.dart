import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:optyma_app/cubit/plantilla/plantilla_cubit.dart';
import 'package:optyma_app/models/plantilla_model.dart';
import 'package:optyma_app/widgets/dropdown_widget.dart';
import 'package:optyma_app/widgets/text_input_widget.dart';
import 'package:optyma_app/widgets/plantilla_input_widget.dart';
class AddPlantillaForm extends StatefulWidget {

  @override
  _AddPlantillaFormState createState() => _AddPlantillaFormState();
}

class _AddPlantillaFormState extends State<AddPlantillaForm> {

  PlantillaModel plantilla;  
  final formKey = GlobalKey<FormState>();
  final List<String> difficultys  = ['1','2','3'];
  final List<String> subjects     = ["Aritmética", "Algebra", "Diferencial", "Optimización"];
  final List<String> time        = ['30', '60', '90', '120'];

  @override
  Widget build(BuildContext context) {

    final PlantillaModel plantillaData = ModalRoute.of(context).settings.arguments;
    if(plantillaData != null){
      plantilla = plantillaData;
    }
    return BlocListener<PlantillaCubit, PlantillaState>(
      listener: (context, state){
        //Submission was a failure
        if(state.status ==4){
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(content: Text('Ocurrio un error al agregar la plantilla')),
          );
        }
        //Submission was a succes
        if(state.status == 3){
          Navigator.pop(context);
        }
      },
      child: Form(  
        key: formKey,
        child: SingleChildScrollView(  
          child: Column(  
            children: [
              DropDownWidget(
                intialValue: (plantilla?.dificultad?.toString()),
                items: difficultys,
                hintText: 'Escoge una dificultad',
                validator: (difficulty) => difficulty == null ? 'Se tiene que escoger una difiultad' : null,
                onSaved: (difficulty){
                  BlocProvider.of<PlantillaCubit>(context).difficultyChanged(int.parse(difficulty));
                },
              ),
              //TODO: change this textinput to validate expresions insted of text
              PlantillaInput(          
                intialValue: plantilla?.exp,        
                labelText: 'Introduzca la expresión',
                onSaved: (exp) {
                  BlocProvider.of<PlantillaCubit>(context).expChanged(exp);
                },
              ),
              TextInput(                 
                intialValue: plantilla?.sentencia, 
                labelText: 'Introduzca la oración',
                onSaved: (sentence) {
                  BlocProvider.of<PlantillaCubit>(context).sentenceChanged(sentence);
                },
              ),
              DropDownWidget(
                intialValue: plantilla?.tema,
                items: subjects,
                hintText: 'Escoge un tema',
                validator: (subject) => subject == null ? 'Se tiene que escoger un tema' : null,
                onSaved: (subject){
                  BlocProvider.of<PlantillaCubit>(context).subjectChanged(subject);
                },
              ),
              DropDownWidget(
                intialValue: plantilla?.tiempoAbierta?.toString(),
                items: time,
                hintText: 'Tiempo para pregunta abierta',
                validator: (time1) => time1 == null ? 'Se tiene que escoger un tiempo' : null,
                onSaved: (time1){
                  BlocProvider.of<PlantillaCubit>(context).time1Changed(int.parse(time1));
                },
              ),
              DropDownWidget(
                intialValue: plantilla?.tiempoAbierta?.toString(),
                items: time,
                hintText: 'Tiempo para pregunta cerrada',
                validator: (time2) => time2 == null ? 'Se tiene que escoger un tiempo' : null,
                onSaved: (time2){
                  BlocProvider.of<PlantillaCubit>(context).time2Changed(int.parse(time2));
                },
              ),

              _addPlantillaButton(),

            ],
          ),
        ),
      ),
    );
  }

  Widget _addPlantillaButton() {
    return BlocBuilder<PlantillaCubit, PlantillaState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state){
        //Submission is in progress
        return state.status == 2
          ? const CircularProgressIndicator()
          : ElevatedButton(
            child: Text('Agregar Plantilla'),
            onPressed: (){
              if(!formKey.currentState.validate()) return;
              formKey.currentState.save();
              BlocProvider.of<PlantillaCubit>(context).validated();
              if(plantilla?.id != null){
                BlocProvider.of<PlantillaCubit>(context).updatePlantillaFormSubmitted(plantilla.id);
              }else{
                BlocProvider.of<PlantillaCubit>(context).addPlantillaFormSubmitted();
              }
            }, 
          );
      },
    );
  }
}