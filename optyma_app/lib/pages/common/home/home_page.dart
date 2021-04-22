import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/bloc/user/user_bloc.dart';
import 'package:optyma_app/pages/user/home/home_user_page.dart';
import 'package:optyma_app/pages/admin/home/home_admin_paga.dart';
import 'package:optyma_app/pages/common/splash/splash_page.dart';


class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if(state is UserUnitialized){
          return SplashPage();
        }
        if(state is UserInitialized){
          if(state.admin){
            return HomeAdminPage();
          }
          else{
            return HomeUserPage();
          }
        }
        else{
          return Container();
        }
      }
    );
  }
}