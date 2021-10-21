import 'package:flutter/cupertino.dart';
import 'package:optyma_app/presentation/game_modes/endless_mode/endless_mode_page.dart';
import 'package:optyma_app/presentation/game_modes/game_modes_page.dart';
import 'package:optyma_app/presentation/home/home_page.dart';
import 'package:optyma_app/presentation/login/login_page.dart';
import 'package:optyma_app/presentation/sign_in/sign_in_page.dart';
import 'package:optyma_app/presentation/splash/splash_page.dart';
import 'package:optyma_app/presentation/users/user_form/user_form_page.dart';
import 'package:optyma_app/presentation/users/users_overview/users_overview_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes(){
  return<String, WidgetBuilder>{
    'login'                 : (_) => LoginPage(),
    'sign-in'               : (_) => SignInPage(),
    'home'                  : (_) => HomePage(),
    'splash'                : (_) => SplashPage(),
    'game-modes'            : (_) => GameModesPage(),
    'endless-mode'          : (_) => EndlessModePage(),
    'users'                 : (_) => UsersOverviewPage(),
    'usersForm'             : (_) => UserFormPage(),
  };
}