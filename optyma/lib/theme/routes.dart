import 'package:flutter/material.dart';
import 'package:optyma/views/common/login_screen.dart';
import 'package:optyma/views/common/registrer_screen.dart';
import 'package:optyma/views/admin/add_plantilla.dart';
import 'package:optyma/views/admin/modify_plantilla.dart';
import 'package:optyma/views/admin/add_admin.dart';
import 'package:optyma/views/home_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String authLogin = '/auth-login';
  static const String authRegister = '/auth-register';
  static const String home = '/home';
  static const String addAdmin = '/add-admin';
  static const String addPlantilla = '/add-plantilla';
  static const String modifyPlantilla = '/modify-plantilla';

  static Map<String, WidgetBuilder> define() {
    return {
      authLogin: (context) => Login(),
      authRegister: (context) => Register(),
      home: (context) => Home(),
      addAdmin: (context) => AddAdmin(),
      addPlantilla: (context)=> AddPlantilla(),
      modifyPlantilla: (context)=> ModifyPlantilla(),
    };
  }
}