import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/bloc/my_bloc_observer.dart';
import 'package:optyma_app/pages/home_page.dart';
import 'package:optyma_app/pages/login/login_page.dart';
import 'package:optyma_app/pages/splash_page.dart';
import 'package:optyma_app/repository/authentication_repository.dart';
import 'package:optyma_app/routes/app_router.dart';

import 'bloc/authentication/authentication_bloc.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  final AuthenticationRepository authenticationRepository = AuthenticationRepository();

  runApp(
    RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (context) => AuthenticationBloc(authenticationRepository: authenticationRepository)
          ..add(AppStarted()),
        child: App(),
      ),
    )
  );
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return SplashPage();
          }
          if (state is Success) {
            return HomePage();
          }
          if (state is Failure) {
            return LoginPage();
          }
          return Container();
        },
      
      ),
      // routes: getApplicationRoutes(),
    );
  }
}