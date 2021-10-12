import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/application/users/user_bloc.dart';
import 'package:optyma_app/presentation/home/admin/home_admin.dart';
import 'package:optyma_app/presentation/home/player/home_player.dart';
import 'package:optyma_app/presentation/splash/splash_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc,UserState>(
      builder: (context, state){
        if(state is LoggedOut){
          return SplashPage();
        }
        if(state is AdminLogged){
          return HomeAdmin();
        }
        if(state is PlayerLogged){
          return HomePlayer();
        }
        return Container();
      }
    );
  }
}