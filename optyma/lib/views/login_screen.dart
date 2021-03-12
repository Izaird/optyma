import 'package:flutter/material.dart';
import 'package:optyma/theme/routes.dart';

class Login extends StatefulWidget {
  @override _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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

    final emailField = TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
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
        hintText: "algo@ejemplo.com",
        labelText: "Correo",
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    final passwordField = Column(
      children: <Widget>[
        TextFormField(
          obscureText: true,
          controller: _passwordController,
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
            hintText: "Contraseña",
            labelText: "Contraseña",
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            hintStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(2.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            MaterialButton(
                child: Text(
                  "Olvidaste tu contraseña",
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(color: Colors.white),
                ),
                onPressed: () {
                  print("test");
                }),
          ],
        ),
      ],
    );

    final fields = Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          emailField,
          passwordField,
        ],
      ),
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
          print("press");
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
              "¿No tienes cuenta?",
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Colors.white,
                  ),
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
                fields,
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
