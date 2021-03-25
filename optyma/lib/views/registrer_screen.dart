import 'dart:async';
import 'package:flutter/material.dart';
import 'package:optyma/theme/routes.dart';
import 'package:optyma/logic/mysql.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

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

  Widget _buildName() {
    return TextFormField(
      style: TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        counterText: '',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        labelText: "Usuario",
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      maxLength: 18,


      validator: (String value) {
        if (value.isEmpty) {
          return 'Se requiere un nombre de usuario';
        }

        if (!RegExp(r"^[a-zA-Z0-9]{4,18}$").hasMatch(value)){
          return 'Introduce un nombre de usuario valido';
        }
        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      style: TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        labelText: "e-mail",
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      validator: (String value) {
      
        if (value.isEmpty) {
          return 'Se requiere un email';
        }

        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Introduce un correo valido';
        }

        return null;
      },
      onSaved: (String value) {
        _email = value;
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      style: TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        counterText: '',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        labelText: "Contraseña",
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),      
      
      keyboardType: TextInputType.visiblePassword,
      maxLength: 18,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Se requiere una contraseña';
        }

        if(!RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,30}$").hasMatch(value)){
          return "Introduce una contraseña valida";
        }

        return null;
      },
      onSaved: (String value) {
        _password = value;
      },
    );
  }

  Widget _buildEscolaridad(){
    return DropdownButtonFormField(
      hint: Text("Escoge una escolaridad"),
      value: _escolaridad,
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

  final registerButton = Material(
    elevation: 5.0,
    borderRadius: BorderRadius.circular(25.0),
    color: Colors.white,
    child: MaterialButton(
      minWidth: mq.size.width / 1.2,
      padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
      child: Text(
        "Registrarse",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: (){
        if (!_formKey.currentState.validate()) {
          return;
        }

        _formKey.currentState.save();
        print(_name);
        print(_email);
        newUser(context);
      },
    ),
  );

  final bottom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        registerButton,
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
      backgroundColor: Color(0xff8c52ff),
      body: Form(
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
    );
  }
}