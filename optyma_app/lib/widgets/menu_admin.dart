import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:optyma_app/bloc/authentication/authentication_bloc.dart';
import 'package:optyma_app/bloc/user/user_bloc.dart';

class MenuAdmin extends StatelessWidget {

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
            title: Text('logros'),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, 'logros');
            },
          ),

          ListTile(
            leading: Icon( FontAwesomeIcons.file, color: Colors.blue ),
            title: Text('Plantillas'),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, 'plantillas');
            },
          ),

          ListTile(
            leading: Icon( FontAwesomeIcons.userShield, color: Colors.blue ),
            title: Text('Administradores'),
            onTap: (){ 
              Navigator.pop(context);
              Navigator.pushNamed(context, 'admins');
            },
          ),


          // Container(
          //   height: relativeHeight * .35,
          // ),

          ListTile(
            leading: Icon( Icons.settings, color: Colors.blue ),
            title: Text('Configuraciones'),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, 'settings');
            }
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