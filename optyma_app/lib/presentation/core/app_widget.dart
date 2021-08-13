import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/application/auth/auth_bloc.dart';
import 'package:optyma_app/injection.dart';
import 'package:optyma_app/presentation/routes/router.gr.dart'
    as app_router;

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _appRouter = app_router.Router();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
            getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested()),
        )
      ],
      child: MaterialApp.router(
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: _appRouter.delegate(
          initialRoutes: [const app_router.SignInPageRoute()],
        ),
        title: 'Optyma',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          primaryColor: Colors.green[800],
          accentColor: Colors.blueAccent,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.blue[900],
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}