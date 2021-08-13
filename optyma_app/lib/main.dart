import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:optyma_app/application/auth/auth_bloc.dart';
import 'package:optyma_app/presentation/core/app_widget.dart';
import 'application/core/my_bloc_observer.dart';
import 'injection.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized(); // need explicit binding before new Firebase call
  await Firebase.initializeApp(); // new Firebase call
  Bloc.observer = MyBlocObserver();
  configureInjection(Environment.prod);


  runApp(MultiBlocProvider(
    providers: [
      BlocProvider( create: (context) =>
        getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested())),
    ], 
    child: AppWidget()
  ));

}