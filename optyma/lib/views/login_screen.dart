import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:optyma/theme/app_theme.dart';
import 'package:optyma/theme/routes.dart';
import 'package:optyma/logic/mysql.dart';
import 'package:crypto/crypto.dart';
import 'package:optyma/widgets/button.dart';
import 'package:optyma/widgets/gradient_back.dart';
import 'dart:convert';
import 'package:optyma/widgets/tf.dart';

class Login extends StatefulWidget {
  @override _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<Login> {
  String _email;
  String _password;
  final _formKey = GlobalKey<FormState>();
  bool adminFlag = false;
  
  var db = new Mysql();
 
  void checkUser(BuildContext context) {
    var bytes = utf8.encode(_password);
    var digest = sha256.convert(bytes);
    String sql;
    //print(context);
    db.getConnection().then((conn) {
      print(this.adminFlag);
      if (this.adminFlag == true){
        sql = "SELECT * FROM optyma.admins WHERE email ='$_email' OR nickname='$_email' AND passwrd='$digest' ;" ;
      }
      else{
        sql = "SELECT * FROM optyma.usuarios_copy WHERE email ='$_email' OR nickname='$_email' AND passwrd='$digest' ;" ;
      }
      
      print(sql);
      conn.query(sql).then( ( results) {
        if(results.length >= 1){
          print("Login succesfull");
          print(results);
          Navigator.of(context).pushNamed(AppRoutes.home);
          }
        else
          print("Error, found no match");   
      });//then
      conn.close();
    });//getConnection().then()
  }//checkUser()

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

  Widget _buttonLogin(){
    return raisedButton(
        textColor: Colors.white,
        minWidth: 300,
        text: "Ingresar",
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
        onClick: () {
          if (!_formKey.currentState.validate()) {
            return;
          }
          
          
          _formKey.currentState.save();
          checkUser(context);
          // _expression_creation_and_evaluation();
          },
    );
  }


  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final logo = Image.asset(
      "assets/logo.png",
      height: mq.size.height / 4,
    );


    final bottom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buttonLogin(),
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Como Administrador",
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Colors.white,
                  ),
            ),
            SizedBox(width: 10),
            Checkbox(value: this.adminFlag,
              onChanged: (bool value){
                setState(() {
                  this.adminFlag = value;  
                });
              },
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.authRegister);
              },
              child: Text(
                "Registrarse",
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
      ),
    );
  }//Widget Build
} //class Login View State
