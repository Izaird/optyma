import 'package:flutter/material.dart';
import 'package:optyma/views/login_screen.dart';
import 'package:optyma/views/registrer_screen.dart';
import 'package:optyma/views/home_screen.dart';
import 'package:optyma/views/admin/add_admin.dart';

class AppRoutes {
  AppRoutes._();

  static const String authLogin = '/auth-login';
  static const String authRegister = '/auth-register';
  static const String home = '/home';
  static const String addAdmin = '/add-admin';

  static Map<String, WidgetBuilder> define() {
    return {
      authLogin: (context) => Login(),
      authRegister: (context) => Register(),
      home: (context) => Home(),
      addAdmin: (context) => AddAdmin(),
    };
  }
}