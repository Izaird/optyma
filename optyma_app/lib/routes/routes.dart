import 'package:flutter/material.dart';


import 'package:optyma_app/pages/common/home/home_page.dart';
import 'package:optyma_app/pages/common/login/login_page.dart';
import 'package:optyma_app/pages/admin/logro/logro_page.dart';
import 'package:optyma_app/pages/common/splash/splash_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes(){
  return <String, WidgetBuilder>{
    'home'         : (_) => HomePage(),
    'splash'        : (_) => SplashPage(),
    'login'         : (_) => LoginPage(),
    'logro'         : (_) => LogroPage(),
  };
}