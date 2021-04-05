import 'package:flutter/material.dart';
import 'package:optyma/theme/routes.dart';
import 'dart:math';
import 'package:math_expressions/math_expressions.dart';

class Home extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<Home>{
  TextEditingController _expController = TextEditingController();
  
  Widget choicebutton(){
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
        onPressed: (){},
        child: Text(
          "Option",
          style: TextStyle(color: Colors.white,
          fontSize: 16.0,
          ),
        ),
        color: Colors.indigo,
        splashColor: Colors.indigoAccent,
        minWidth: 200.0,
        height: 45.0,
        shape: RoundedRectangleBorder (borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }

@override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color(0xff8c0000),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(12.0) ,
              alignment: Alignment.centerLeft,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Racha: ', 
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                   ), 
                    Expanded(
                      child: Text(
                      'Puntuacion: ', 
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child:Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: Expanded(
                child: Text(
                  'Pregunta: ', 
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
            ), 
          ),  
          Expanded(
            flex: 6,
            child: Container(
              child: Column(
                 children: <Widget>[
                   choicebutton(),
                   choicebutton(),
                   choicebutton(),
                   choicebutton(),
                 ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.teal, 
              ),
            ),
          ),
        ], 
      ),
    );
  }
}