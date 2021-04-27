import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:optyma_app/cubit/plantilla/plantilla_cubit.dart';
import 'package:optyma_app/widgets/dropdown_widget.dart';
import 'package:optyma_app/widgets/text_input_widget.dart';

class AddPlantillaForm extends StatelessWidget {

  final formKey = GlobalKey<FormState>();
  final List<String> difficultys  = ['1','2','3'];
  final List<String> subjects     = ["Aritmética", "Algebra", "Diferencial", "Optimización"];
  final List<String> time        = ['30', '60', '90', '120'];
  @override
  Widget build(BuildContext context) {
    return BlocListener<PlantillaCubit, PlantillaState>(
      listener: (context, state){
        //Submission was a failure
        if(state.status ==4){
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(content: Text('Ocurrio un error al agregar el logro')),
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
                items: difficultys,
                hintText: 'Escoge una dificultad',
                validator: (difficulty) => difficulty == null ? 'Se tiene que escoger una difiultad' : null,
                onSaved: (difficulty){
                  BlocProvider.of<PlantillaCubit>(context).difficultyChanged(int.parse(difficulty));
                },
              ),
              //TODO: change this textinput to validate expresions insted of text
              TextInput(                  
                labelText: 'Introduzca la expresión',
                onSaved: (exp) {
                  BlocProvider.of<PlantillaCubit>(context).expChanged(exp);
                },
              ),
              TextInput(                  
                labelText: 'Introduzca la oración',
                onSaved: (sentence) {
                  BlocProvider.of<PlantillaCubit>(context).sentenceChanged(sentence);
                },
              ),
              DropDownWidget(
                items: subjects,
                hintText: 'Escoge un tema',
                validator: (subject) => subject == null ? 'Se tiene que escoger un tema' : null,
                onSaved: (subject){
                  BlocProvider.of<PlantillaCubit>(context).subjectChanged(subject);
                },
              ),
              DropDownWidget(
                items: time,
                hintText: 'Tiempo para pregunta abierta',
                validator: (time1) => time1 == null ? 'Se tiene que escoger un tiempo' : null,
                onSaved: (time1){
                  BlocProvider.of<PlantillaCubit>(context).time1Changed(int.parse(time1));
                },
              ),
              DropDownWidget(
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
            child: Text('Agreagar logro'),
            onPressed: (){
              if(!formKey.currentState.validate()) return;
              formKey.currentState.save();
              BlocProvider.of<PlantillaCubit>(context).validated();
              BlocProvider.of<PlantillaCubit>(context).plantillaFormSubmitted();
            }, 
          );
      },
    );
  }
}