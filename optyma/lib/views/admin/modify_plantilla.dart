import 'package:flutter/material.dart';
import 'package:optyma/theme/app_theme.dart';
import 'package:optyma/theme/routes.dart';
import 'package:optyma/logic/mysql.dart';
import 'package:crypto/crypto.dart';
import 'package:optyma/widgets/button.dart';
import 'package:optyma/widgets/dropdown.dart';
import 'package:optyma/widgets/gradient_back.dart';
import 'dart:convert';
import 'package:optyma/widgets/tf.dart';

class ModifyPlantilla extends StatefulWidget {
  @override
  _ModifyPlantillaViewState createState() => _ModifyPlantillaViewState();
}



class _ModifyPlantillaViewState extends State<ModifyPlantilla> {
  //User data
  String _tema;
  String _expresion;
  String _ejercicio;
  String _tiempo1;
  String _tiempo2;

  final _formKey = GlobalKey<FormState>();
  
  Widget _buildTema(){
    return DropDownWidget(
      items: ["Aritmética", "Algebra", "Diferencial", "Optimización"],
      hintText: "Escoge un tema",
      prefixIcon: Icon(Icons.school),
      onSaved: (input)=> _tema= input,
      validator: (value) => value == null ? "Se requiere escoger un tema" : null,
  );
 }

  Widget _builExpresion(){
      return TextFormFieldWidget(
      hintText: "Expresion",
      textInputType: TextInputType.name,
      actionKeyboard: TextInputAction.done,
      validator: (input){
        if (input.isEmpty) {
          return 'Se requiere una expresion';
        }

        return null;
      },
      onSaved: (input)=> _expresion= input,
    );
  }


  Widget _buildEjercicio(){
      return TextFormFieldWidget(
      hintText: "Ejercicio",
      textInputType: TextInputType.name,
      actionKeyboard: TextInputAction.done,
      validator: (input){
        if (input.isEmpty) {
          return 'Se requiere un ejercicio';
        }

        return null;
      },
      onSaved: (input)=> _ejercicio= input,
    );
  }


  Widget _buildTiempo1(){
      return TextFormFieldWidget(
      hintText: "Tiempo",
      textInputType: TextInputType.phone,
      actionKeyboard: TextInputAction.done,
      validator: (input){
        if (input.isEmpty) {
          return 'Se requiere un tiempo';
        }

        if (!RegExp(r"^([1-9]|[1-5][0-9]|60)$").hasMatch(input)){
          return 'Introduce un tiempo valido';
        }

        return null;
      },
      onSaved: (input)=> _tiempo1= input,
    );
  }


  Widget _buildTiempo2(){
      return TextFormFieldWidget(
      hintText: "Tiempo",
      textInputType: TextInputType.emailAddress,
      actionKeyboard: TextInputAction.done,
      validator: (input){
        
        if (input.isEmpty) {
          return 'Se requiere un tiempo';
        }

        if (!RegExp(r"^([1-9]|[1-5][0-9]|60)$").hasMatch(input)){
          return 'Introduce un tiempo valido';
        }

        return null;
      },
      onSaved: (input)=> _tiempo2= input,
    );
  }



  @override
  Widget build(BuildContext context) {

  final mq = MediaQuery.of(context);
  
  Widget _confirmarButton(){
    return raisedButton(
      text: "Confirmar",
      onClick: (){
        if (!_formKey.currentState.validate()) {
          return;
        }

        _formKey.currentState.save();
        print(_tiempo1);
        print(_tiempo2);
      },
    );
  }

  Widget _descartarButton(){
    return raisedButton(
      text: "Descartar",
      onClick: (){
        if (!_formKey.currentState.validate()) {
          return;
        }

        _formKey.currentState.save();
        print(_tiempo1);
        print(_tiempo2);
      },
    );
  }

  final bottom = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Expanded(
          child: Container(
            child: _confirmarButton(),
            padding: EdgeInsets.symmetric(horizontal: 10),
          ),
        ),
        Expanded(
          child: Container(
            child: _descartarButton(),
            padding: EdgeInsets.symmetric(horizontal: 10),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
      ],
    );



    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          GradientBack(height:null),

      Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(36),
          child: Container(
            height: mq.size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildTema(),
                _builExpresion(),
                _buildEjercicio(),
                _buildTiempo1(),
                _buildTiempo2(),
                Padding(
                  padding: EdgeInsets.only(bottom: 150),
                  child: bottom,
                ),
              ],
            ),
          ),
        ),
      ),

        ],
        )
      
    );
  }
}
    