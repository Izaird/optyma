import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/application/auth/auth_bloc.dart';
import 'package:optyma_app/presentation/home/home_page.dart';
import 'package:optyma_app/presentation/login/login_page.dart';
import 'package:optyma_app/presentation/routes/routes.dart';
import 'package:optyma_app/presentation/splash/splash_page.dart';

class AppWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: getApplicationRoutes(),
      title: 'Optyma',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.green[800],
        accentColor: Colors.blueAccent,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.blue[900],
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state){
          if(state is Initial){
            return SplashPage();
          }
          if(state is Aunthenticated){
            return HomePage();
          }
          if (state is Unaunthenticated){
            return LoginPage();
          }

          return Container();
        }
      ),
    );
  }
}