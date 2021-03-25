import 'package:flutter/material.dart' hide Interval;
import 'package:optyma/theme/routes.dart';
import 'package:optyma/logic/mysql.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:math';
import 'package:math_expressions/math_expressions.dart';

class Login extends StatefulWidget {
  @override _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<Login> {
  String _email;
  String _password;
  final _formKey = GlobalKey<FormState>();
  bool adminFlag = false;
  
  var db = new Mysql();
  var response = '';
  var express = '2 * a';
  List rangesExp = [ [750, 1250],
                      [125,785] ];
  void _expression_creation_and_evaluation( ) {
  print('\nExample 1: Expression creation and evaluation\n');

  // You can either create an mathematical expression programmatically or parse
  // a string.
  // (1a) Parse expression:
  Parser p = Parser();
  Parser p2 = Parser();
  Random rnd = new Random();
  List<Variable> vars =[];
  Expression exp = p.parse('((x^2 + cos(y)) / 3) + t');
  Expression g = p2.parse('2 * a');
  IntervalLiteral exp2 = new IntervalLiteral(new Number(2500), new Number(3000));
  //print('---------------');
  //print(double.parse(exp2.max.toString()));
  //print('---------------');
  Variable t = new Variable('t'); 
  // (1b) Build expression: (x^2 + cos(y)) / 3
  Variable x = Variable('x'), y = Variable('y');
  Variable a = Variable('a');
  vars.add(a);
  //Power xSquare = Power(x, 2);
  //Cos yCos = Cos(y);
  //Number three = Number(3.0);
  //exp = (xSquare + yCos) / three;

  // Bind variables and evaluate the expression as real number.
  // (2) Bind variables:
  int r1 = rangesExp[0][0]+rnd.nextInt(rangesExp[0][1]-rangesExp[0][0]);
  ContextModel cm = ContextModel()
    ..bindVariable(x, Number(2))
    ..bindVariable(y, Number(pi))
    ..bindVariable(t, Number(r1));
  ContextModel cm2 = ContextModel()
    ..bindVariable(vars[0], Number(r1));
    //..bindVariable(b, Number(3200.0));
  // (3) Evaluate expression:
  double eval = exp.evaluate(EvaluationType.REAL, cm);
  double gEval = g.evaluate(EvaluationType.REAL,cm2); 
  //double eval2 = exp2.evaluate(EvaluationType.INTERVAL, cm2);
  print('Expression: $exp');
  print('Evaluated expression: $eval\n  (with context: $cm)'); // = 1
  print('***Expression: $g ***');
  print('***Evaluated expression: $gEval\n  (with context: $cm2)***'); // = 1
}

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

        if(!RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$").hasMatch(value)){
          return "Introduce una contraseña valida";
        }

        return null;
      },
      onSaved: (String value) {
        _password = value;
      },
    );
  }

  
  
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    // void showAlertDialog(BuildContext context) {
    //   showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         TextEditingController _emailControllerField =
    //             TextEditingController();
    //         return CustomAlertDialog(
    //           content: Container(
    //             width: MediaQuery.of(context).size.width / 1.2,
    //             height: MediaQuery.of(context).size.height / 4.5,
    //             color: Colors.white,
    //             child: Column(
    //               children: <Widget>[
    //                 Text("Insert Reset Email:"),
    //                 TextField(
    //                   controller: _emailControllerField,
    //                   decoration: InputDecoration(
    //                     focusedBorder: UnderlineInputBorder(
    //                       borderSide: BorderSide(
    //                         color: Colors.black,
    //                       ),
    //                     ),
    //                     hintText: "something@example.com",
    //                     labelText: "Email",
    //                     labelStyle: TextStyle(
    //                       color: Colors.black,
    //                     ),
    //                     hintStyle: TextStyle(
    //                       color: Colors.black,
    //                     ),
    //                   ),
    //                 ),
    //                 Padding(
    //                   padding: EdgeInsets.all(15),
    //                   child: Material(
    //                     elevation: 5.0,
    //                     borderRadius: BorderRadius.circular(25.0),
    //                     color: Color(0xff8c52ff),
    //                     child: MaterialButton(
    //                       minWidth: mq.size.width / 2,
    //                       padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
    //                       child: Text(
    //                         "Send Reset Email",
    //                         textAlign: TextAlign.center,
    //                         style: TextStyle(
    //                           fontSize: 20.0,
    //                           color: Colors.white,
    //                           fontWeight: FontWeight.bold,
    //                         ),
    //                       ),
    //                       onPressed: (){
                            
    //                       },
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //         );
    //       });
    // }

    final logo = Image.asset(
      "assets/logo.png",
      height: mq.size.height / 4,
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: mq.size.width / 1.2,
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: Text(
          "Ingresar",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          if (!_formKey.currentState.validate()) {
            return;
          }
          
          
          _formKey.currentState.save();
          checkUser(context);
          // _expression_creation_and_evaluation();
          },
      ),
    );

    final bottom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        loginButton,
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
    );
  }//Widget Build
} //class Login View State
