
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:optyma_app/models/logro_model.dart';
import 'package:optyma_app/repository/cloud_firestore_repository.dart';
import 'package:optyma_app/utils/validators.dart' as validators;


final formKey = GlobalKey<FormState>();
LogroModel logro = new LogroModel();

class AddLogroPage extends StatefulWidget {


  @override
  _AddLogroPageState createState() => _AddLogroPageState();
}

class _AddLogroPageState extends State<AddLogroPage> {


final CloudFirestoreRepository logrosRepository = CloudFirestoreRepository();


  @override
  Widget build(BuildContext context) {
  return RepositoryProvider.value(
      value: logrosRepository,
      child: Scaffold(
      appBar: AppBar(
        title: Text('Title Page'),
      ),

      body: SingleChildScrollView(
        child: Container(  
          padding: EdgeInsets.all(15.0),
          child: Form(  
            key: formKey,
            child: Column(  
              children: [  
                CreateName(),
                CreateDescription(),
                CreateButton()
              ],
            ),
          ),
        ),
      ),
      ),
  );
  }
}

class CreateButton extends StatelessWidget {
  const CreateButton({
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      label: Text('Guardar logro'),
      icon: Icon(Icons.save),
      onPressed:(){ 

    if(!formKey.currentState.validate()) return;

    formKey.currentState.save();

    RepositoryProvider.of<CloudFirestoreRepository>(context).addLogro(logro);


    print(logro.nombre);
    print(logro.descripcion);
      }, 
    );
  }



}

class CreateDescription extends StatelessWidget {
  const CreateDescription({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: logro.descripcion,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(  
        labelText: 'Producto'
      ),
      onSaved: (descripcion) => logro.descripcion = descripcion,
      validator: (value) {
        if(validators.isText(value)){
          return null;
        }
        else{
          return 'Ingrese una descripción valida';
        }
      },
    );
  }
}

class CreateName extends StatelessWidget {
  const CreateName({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: logro.nombre,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(  
        labelText: 'Nombre'
      ),
      onSaved: (nombre) => logro.nombre = nombre,
      validator: (value) {
        if(validators.isText(value)){
          return null;
        }
        else{
          return 'Ingrese un nombre valido';
        }
      },
    );
  }
}