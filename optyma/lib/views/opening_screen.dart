import 'package:flutter/material.dart';
import 'package:optyma/theme/app_theme.dart';
import 'package:optyma/theme/routes.dart';
import 'package:optyma/widgets/button.dart';
import 'package:optyma/widgets/gradient_back.dart';

class OpeningView extends StatelessWidget{



  @override

  Widget build(BuildContext context){
    final mq = MediaQuery.of(context);
    final logo = Image.asset("assets/logo.png", fit: BoxFit.contain,);

  Widget _loginButton(){
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
      onClick: (){
        Navigator.of(context).pushNamed(AppRoutes.authLogin);
      },
    );
  }

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
        Navigator.of(context).pushNamed(AppRoutes.authRegister);
      },
    );
  }

  Widget _testButton(){
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
        Navigator.of(context).pushNamed(AppRoutes.addAdmin);
      },
    );
  }

    final buttons = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // _testButton(),
        _loginButton(),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 15, 0, 70),
          child: _registerButton(),
        ),
      ],
    );



    return Scaffold(

      body: Stack( 
        alignment: Alignment.center,
        children: <Widget>[
          GradientBack(height:null),


      Padding(
        padding: EdgeInsets.all(36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: logo,
            ),
            Padding(
              padding: EdgeInsets.only(top: 50, bottom: 50),
              // child: display(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50, bottom: 50),
              child: buttons,
            )
          ],
        ),
      ),


        ],
      ),
      
    );
  }
}
