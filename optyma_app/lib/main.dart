import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/bloc/my_bloc_observer.dart';
import 'package:optyma_app/bloc/user/user_bloc.dart';
import 'package:optyma_app/pages/common/home/home_page.dart';
import 'package:optyma_app/pages/common/login/login_page.dart';
import 'package:optyma_app/pages/common/splash/splash_page.dart';
import 'package:optyma_app/repository/authentication_repository.dart';
import 'package:optyma_app/repository/logros_repository.dart';
import 'package:optyma_app/repository/plantillas_repository.dart';
import 'package:optyma_app/repository/users_repository.dart';
import 'package:optyma_app/routes/routes.dart';

import 'bloc/authentication/authentication_bloc.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  final AuthenticationRepository authenticationRepository = AuthenticationRepository();
  final UsersRepository cloudFirestoreRepository = UsersRepository();
  final LogrosRepository logrosRepository = LogrosRepository();
  final PlantillasRepository plantillasRepository = PlantillasRepository();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authenticationRepository),
        RepositoryProvider.value(value: cloudFirestoreRepository),
        RepositoryProvider.value(value: logrosRepository),
        RepositoryProvider.value(value: plantillasRepository),
      ],

      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationBloc(authenticationRepository: authenticationRepository)
              ..add(AppStarted()),
          ),
          BlocProvider(
            create: (context) => UserBloc(
              authenticationRepository: authenticationRepository,
              cloudFirestoreRepository: cloudFirestoreRepository
            )
          ),
        ],
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
      routes: getApplicationRoutes(),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUninitialized) {
            return SplashPage();
          }
          if (state is AuthenticationSuccess) {
            BlocProvider.of<UserBloc>(context).add(UserLoggedIn());
            return HomePage();
          }
          if (state is AuthenticationFailure) {
            return LoginPage();
          }
          return Container();
        },
      
      ),
      // routes: getApplicationRoutes(),
    );
  }
}