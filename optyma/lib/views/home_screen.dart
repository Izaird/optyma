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


@override
  Widget build(BuildContext context) {
    final expField = TextFormField(
      controller: _expController,
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
        hintText: "a + b",
        labelText: "Expresion",
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Color(0xff8c0000),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(36),
        child: Container(
          
        ),
      ),
    );
  }
}