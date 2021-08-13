import 'package:auto_route/annotations.dart';
import 'package:optyma_app/presentation/home/home_page.dart';
import 'package:optyma_app/presentation/sign_in/sign_in_page.dart';
import 'package:optyma_app/presentation/splash/splash_page.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: SplashPage, initial: true),
    MaterialRoute(page: SignInPage),
    MaterialRoute(page: HomePage),
  ],
)
class $Router {}