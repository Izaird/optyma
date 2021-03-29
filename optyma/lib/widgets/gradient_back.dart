import 'package:flutter/material.dart';
import 'package:optyma/theme/app_theme.dart';

class GradientBack extends StatelessWidget {
  double height;

  GradientBack({Key key, this.height}); //height = null full screen

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidht = MediaQuery.of(context).size.width;

    if (height == null) {
      height = screenHeight;
    }

    return Container(
      width: screenWidht,
      height: height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFF0077b6), Color(0xFF48cae4)],
              begin: FractionalOffset(0.2, 0.0),
              end: FractionalOffset(1.0, 0.6),
              stops: [0.0, 0.6],
              tileMode: TileMode.clamp)),

      child: FittedBox(
        fit: BoxFit.none,
        alignment: Alignment(-1.5, -0.8),
        child: Container(
          width: screenHeight,
          height: screenHeight,
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            borderRadius: BorderRadius.circular(screenHeight / 2),
          ),
        ),
      ),
      /*Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          fontFamily: "Lato",
          fontWeight: FontWeight.bold
        ),
      )*/

      //alignment: Alignment(-0.9, -0.6),
    );
  }
}
