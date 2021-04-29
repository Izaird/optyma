import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/cubit/logro/logro_cubit.dart';
import 'package:optyma_app/models/logro_model.dart';
import 'package:optyma_app/widgets/text_input_widget.dart';

class AddLogroForm extends StatefulWidget{
  @override
  _AddLogroFormState createState() => _AddLogroFormState();
}

class _AddLogroFormState extends State<AddLogroForm> {
  final formKey = GlobalKey<FormState>();

  LogroModel logro = new LogroModel();

  @override
  Widget build(BuildContext context) {

    final LogroModel logroData = ModalRoute.of(context).settings.arguments;
    if (logroData != null ){
      logro = logroData;
    }

    return BlocListener<LogroCubit, LogroState>(
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextInput(
                intialData: logro.name,
                labelText: 'Ingrese el nombre del logro',
                onSaved: (name) {
                  BlocProvider.of<LogroCubit>(context).nameChanged(name);
                },
              ),
              TextInput(
                intialData: logro.description,
                maxLenght: 50,
                labelText: 'Ingrese la descripción del logro',
                onSaved: (description) {
                  BlocProvider.of<LogroCubit>(context).descriptionChanged(description);
                },
              ),
              _addLogroButton(),
            ],
          ),
        )
      ),
    );
  }

  Widget _addLogroButton() {
    return BlocBuilder<LogroCubit, LogroState>(
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
              BlocProvider.of<LogroCubit>(context).validated();
              if(logro.id != null){
                BlocProvider.of<LogroCubit>(context).updateLogroFormSubmitted(logro.id);
              }else{
                BlocProvider.of<LogroCubit>(context).addLogroFormSubmitted();
              }
            }, 
          );
      },
    );
  }
}

