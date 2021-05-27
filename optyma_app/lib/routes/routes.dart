import 'package:flutter/material.dart';


import 'package:optyma_app/pages/admin/admins/add_admin_page.dart';
import 'package:optyma_app/pages/admin/admins/admins_page.dart';
import 'package:optyma_app/pages/admin/logro/logros_list/logros_list_page.dart';
import 'package:optyma_app/pages/admin/home/home_admin_page.dart';
import 'package:optyma_app/pages/admin/settings/settings_page.dart';

import 'package:optyma_app/pages/common/home/home_page.dart';
import 'package:optyma_app/pages/common/login/login_page.dart';
import 'package:optyma_app/pages/admin/logro/add_logro/add_logro_page.dart';
import 'package:optyma_app/pages/common/signup/signup_page.dart';
import 'package:optyma_app/pages/common/splash/splash_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes(){
  return <String, WidgetBuilder>{
    //Common pages
    'home'          : (_) => HomePage(),
    'splash'        : (_) => SplashPage(),
    'login'         : (_) => LoginPage(),
    'signup'        : (_) => SignUpPage(),
    //user pages
    // 'quiz'          :(_) => Quiz(),
    //Admin Pages
    'homeAdmin'     : (_) => HomeAdminPage(),
    'logros'        : (_) => LogrosListPage(),
    'addLogro'      : (_) => AddLogroPage(),
    // 'plantillas'    : (_) => PlantillasPage(),
    // 'addPlantilla'  : (_) => AddPlantillaPage(),
    'admins'        : (_) => AdminsPage(),
    'addAdmin'      : (_) => AddAdminPage(),
    'settings'      : (_) => SettingsPage(),
  };
}