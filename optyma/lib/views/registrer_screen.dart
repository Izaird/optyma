import 'package:flutter/material.dart';
import 'package:optyma/theme/app_theme.dart';
import 'package:optyma/theme/routes.dart';
import 'package:optyma/logic/mysql.dart';
import 'package:crypto/crypto.dart';
import 'package:optyma/widgets/button.dart';
import 'package:optyma/widgets/gradient_back.dart';
import 'dart:convert';

import 'package:optyma/widgets/tf.dart';

class Register extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}



class _RegisterViewState extends State<Register> {
  //
  List escolaridades = [
    "Primaria", "Secundaria", "Preparatoria", "Universidad"
  ];
  //User data
  String _name;
  String _email;
  String _password;
  String _escolaridad;

  final _formKey = GlobalKey<FormState>();
  
  var db = new Mysql();
  var response = '';

  void newUser(BuildContext context){
    var bytes = utf8.encode(_password);
    var digest = sha256.convert(bytes);
    //print(context);
    db.getConnection().then((conn) {
      //print(user);
      String sql = "INSERT INTO usuarios_copy (email,nickname,escolaridad,passwrd,created_at) VALUES ('$_email','$_name','$_escolaridad','$digest',NOW()) ;" ;
      print(sql);
      conn.query(sql)
      .then( ( results) {
        Navigator.of(context).pushNamed(AppRoutes.authLogin);//print(results);returns empty if succesfull   
      });//then
      conn.close();
    });//getConnection().then()
  }//_newUser()

  Widget _buildName(){
      return TextFormFieldWidget(
      hintText: "Nombre",
      textInputType: TextInputType.name,
      actionKeyboard: TextInputAction.done,
      parametersValidate: "Introduce un nombre usuario",
      prefixIcon: Icon(Icons.person),
      validator: (input){
        if (input.isEmpty) {
          return 'Se requiere un nombre de usuario';
        }

        if (!RegExp(r"^[a-zA-Z0-9]{4,18}$").hasMatch(input)){
          return 'Introduce un nombre de usuario valido';
        }

        return null;
      },
      onSaved: (input)=> _name= input,
    );
  }


  Widget _buildEmail(){
      return TextFormFieldWidget(
      hintText: "email",
      textInputType: TextInputType.emailAddress,
      actionKeyboard: TextInputAction.done,
      parametersValidate: "Introduce tu correo",
      prefixIcon: Icon(Icons.email),
      validator: (input){
        
        if (input.isEmpty) {
          return 'Se requiere un email';
        }

        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(input)) {
          return 'Introduce un correo valido';
        }

        return null;
      },
      onSaved: (input)=> _email = input,
    );
  }

  Widget _buildPassword(){
    return TextFormFieldWidget(
      obscureText: true,
      hintText: "Contraseña",
      textInputType: TextInputType.visiblePassword,
      actionKeyboard: TextInputAction.done,
      parametersValidate: "Introduce tu contraseña",
      prefixIcon: Icon(Icons.lock_open),
      validator:(input){
        if (input.isEmpty) {
          return 'Se requiere una contraseña';
        }

        if(!RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$").hasMatch(input)){
          return "Introduce una contraseña valida";
        }

        return null;
      },
      onSaved: (input)=> _password = input,
    );
  }

  Widget _buildEscolaridad(){
    return DropdownButtonFormField(
      hint: Text("Escoge una escolaridad"),
      value: escolaridades[0],
      onChanged: (newValue){
        setState(() {
          _escolaridad = newValue;
        });
      },
      items: escolaridades.map((valueItem){
        return DropdownMenuItem(
          value: valueItem,
          child: Text(valueItem),
        );
      }).toList(),
      
  );
  
  }

  @override
  Widget build(BuildContext context) {

  final mq = MediaQuery.of(context);
  
  final logo = Image.asset(
      "assets/logo.png",
      height: mq.size.height / 4,
    );


  Widget _registerButton(){
    return raisedButton(
        textColor: Colors.white,
        minWidth: 300,
        text: "Registrarse",
        height: 50.0,
        borderRadius: 100,
        color: AppTheme.colors.powderBlue,
        borderSideColor: Colors.white,
        splashColor: Colors.blue[200],
        style: TextStyle(
          color: AppTheme.colors.powderBlue,
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          letterSpacing: 1.2,
        ),
      onClick: (){
        if (!_formKey.currentState.validate()) {
          return;
        }

        _formKey.currentState.save();
        print(_name);
        print(_email);
        newUser(context);
      },
    );
  }

  final bottom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _registerButton(),
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "¿Ya tienes cuenta?",
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Colors.white,
                  ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.authLogin);
              },
              child: Text(
                "Ingresar",
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
              ),
            ),
          ],
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
                logo,
                _buildName(),
                _buildEmail(),
                _buildPassword(),
                _buildEscolaridad(),
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