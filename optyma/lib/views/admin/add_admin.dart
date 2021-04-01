import 'package:flutter/material.dart';
import 'package:optyma/theme/app_theme.dart';
import 'package:optyma/theme/routes.dart';
import 'package:optyma/logic/mysql.dart';
import 'package:crypto/crypto.dart';
import 'package:optyma/widgets/button.dart';
import 'package:optyma/widgets/gradient_back.dart';
import 'dart:convert';
import 'package:optyma/widgets/tf.dart';

class AddAdmin extends StatefulWidget {
  @override
  _AddAdminViewState createState() => _AddAdminViewState();
}



class _AddAdminViewState extends State<AddAdmin> {
  //
  //User data
  String _name;
  String _apellidoPaterno;
  String _apellidoMaterno;
  String _email;
  String _password;

  final _formKey = GlobalKey<FormState>();
  
  // var db = new Mysql();
  // var response = '';

  // void newUser(BuildContext context){
  //   var bytes = utf8.encode(_password);
  //   var digest = sha256.convert(bytes);
  //   //print(context);
  //   db.getConnection().then((conn) {
  //     //print(user);
  //     String sql = "INSERT INTO usuarios_copy (email,nickname,escolaridad,passwrd,created_at) VALUES ('$_email','$_name','$_escolaridad','$digest',NOW()) ;" ;
  //     print(sql);
  //     conn.query(sql)
  //     .then( ( results) {
  //       Navigator.of(context).pushNamed(AppRoutes.authLogin);//print(results);returns empty if succesfull   
  //     });//then
  //     conn.close();
  //   });//getConnection().then()
  // }//_newUser()

  Widget _buildName(){
      return TextFormFieldWidget(
      hintText: "Nombre",
      textInputType: TextInputType.name,
      actionKeyboard: TextInputAction.done,
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


  Widget _buildApellidoP(){
      return TextFormFieldWidget(
      hintText: "Apellido Paterno",
      textInputType: TextInputType.name,
      actionKeyboard: TextInputAction.done,
      prefixIcon: Icon(Icons.person),
      validator: (input){
        if (input.isEmpty) {
          return 'Se requiere un apellido';
        }

        if (!RegExp(r"^[a-zA-Z0-9]{4,18}$").hasMatch(input)){
          return 'Introduce un apellido valido';
        }

        return null;
      },
      onSaved: (input)=> _apellidoPaterno= input,
    );
  }


  Widget _buildApellidoM(){
      return TextFormFieldWidget(
      hintText: "Apellido Materno",
      textInputType: TextInputType.name,
      actionKeyboard: TextInputAction.done,
      prefixIcon: Icon(Icons.person),
      validator: (input){
        if (input.isEmpty) {
          return 'Se requiere un apellido';
        }

        if (!RegExp(r"^[a-zA-Z0-9]{4,18}$").hasMatch(input)){
          return 'Introduce un apellido valido';
        }

        return null;
      },
      onSaved: (input)=> _apellidoMaterno= input,
    );
  }


  Widget _buildEmail(){
      return TextFormFieldWidget(
      hintText: "email",
      textInputType: TextInputType.emailAddress,
      actionKeyboard: TextInputAction.done,
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


  @override
  Widget build(BuildContext context) {

  final mq = MediaQuery.of(context);
  
  Widget _registerButton(){
    return raisedButton(
        text: "Registrar",
      onClick: (){
        if (!_formKey.currentState.validate()) {
          return;
        }

        _formKey.currentState.save();
        print(_name);
        print(_email);
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
                _buildName(),
                _buildApellidoP(),
                _buildApellidoM(),
                _buildEmail(),
                _buildPassword(),
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
    