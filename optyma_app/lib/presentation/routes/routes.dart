import 'package:flutter/cupertino.dart';
import 'package:optyma_app/presentation/home/home_page.dart';
import 'package:optyma_app/presentation/login/login_page.dart';
import 'package:optyma_app/presentation/sign_in/sign_in_page.dart';
import 'package:optyma_app/presentation/splash/splash_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes(){
  return<String, WidgetBuilder>{
    'login'                 : (_) => LoginPage(),
    'sign-in'               : (_) => SignInPage(),
    'home'                  : (_) => HomePage(),
    'splash'                : (_) => SplashPage(),
  };
}