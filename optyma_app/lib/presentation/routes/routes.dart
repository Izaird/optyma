import 'package:flutter/cupertino.dart';
import 'package:optyma_app/presentation/game_modes/classic_mode/classic_mode_page.dart';
import 'package:optyma_app/presentation/auth/login/login_page.dart';
import 'package:optyma_app/presentation/auth/password_forgotten/password_forgotten_page.dart';
import 'package:optyma_app/presentation/auth/sign_in/sign_in_page.dart';
import 'package:optyma_app/presentation/game_modes/PvPLocal/pvp_mode_page.dart';
import 'package:optyma_app/presentation/game_modes/endless_mode/endless_mode_page.dart';
import 'package:optyma_app/presentation/game_modes/game_modes_page.dart';
import 'package:optyma_app/presentation/home/home_page.dart';
import 'package:optyma_app/presentation/splash/splash_page.dart';
import 'package:optyma_app/presentation/templates/template_form/template_form_page.dart';
import 'package:optyma_app/presentation/templates/templates_overviews/templates_overview_page.dart';
import 'package:optyma_app/presentation/users/user_form/user_form_page.dart';
import 'package:optyma_app/presentation/users/users_overview/users_overview_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes(){
  return<String, WidgetBuilder>{
    'login'                 : (_) => LoginPage(),
    'sign-in'               : (_) => SignInPage(),
    'home'                  : (_) => HomePage(),
    'splash'                : (_) => SplashPage(),
    'game-modes'            : (_) => GameModesPage(),
    'classic-mode'          : (_) => ClassicModePage(),
    'endless-mode'          : (_) => EndlessModePage(),
    'users'                 : (_) => UsersOverviewPage(),
    'usersForm'             : (_) => UserFormPage(),
    'templates-overview'    : (_) => TemplatesOverviewPage(),
    'template-form'         : (_) => TemplateFormPage(),
    'pvp'                   : (_) => PvPPage(),
    'password-forgotten'    : (_) => PasswordForgottenPage(),
  };
}