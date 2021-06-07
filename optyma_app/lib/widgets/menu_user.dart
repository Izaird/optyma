import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:optyma_app/bloc/authentication/authentication_bloc.dart';
import 'package:optyma_app/bloc/user/user_bloc.dart';

class MenuUser extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // final relativeHeight = MediaQuery.of(context).size.height;
    return Drawer(
      child: ListView(  
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader( 
            child: Container(),
            decoration: BoxDecoration(  
              gradient: LinearGradient(  
                colors: [
                  Color(0xff0096C7), 
                  Color(0xff48CAE4)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                // stops: [0.6, 1]
              ),
            ),
          ),

          ListTile(
            leading: Icon(FontAwesomeIcons.award, color: Colors.blue),
            title: Text('Logros'),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, 'logrosUnlocked');
            },
          ),

          ListTile(
            leading: Icon(FontAwesomeIcons.signOutAlt, color: Colors.blue),
            title: Text('Cerrar sesión'),
            onTap: (){
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
              BlocProvider.of<UserBloc>(context).add(UserLoggedOut());
            },
          ),
        ],
      ),
    );
  }
}