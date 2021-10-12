import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:optyma_app/application/auth/auth_bloc.dart';
import 'package:optyma_app/application/users/user_bloc.dart';

class AdminNavigationMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    // final relativeHeight = MediaQuery.of(context).size.height;
    return Drawer(
      child: ListView(  
        padding: EdgeInsets.zero,
        children: const [
          Header(),
          InfiniteMode(),
          Users(),
          LogOut(),
        ],
      ),
    );
  }
}

class LogOut extends StatelessWidget {
  const LogOut({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(FontAwesomeIcons.signOutAlt, color: Colors.blue),
      title: const Text('Cerrar sesión'),
      onTap: (){
        BlocProvider.of<UserBloc>(context).add(const UserEvent.loggedOut());
        BlocProvider.of<AuthBloc>(context).add(const AuthEvent.loggedOut());
      },
    );
  }
}

class InfiniteMode extends StatelessWidget {
  const InfiniteMode({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(FontAwesomeIcons.gamepad, color: Colors.blue),
      title: const Text('Juegos'),
      onTap: (){
        Navigator.pop(context);
        Navigator.pushNamed(context, 'game-modes');
      },
    );
  }
}


class Users extends StatelessWidget {
  const Users({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(FontAwesomeIcons.users, color: Colors.blue),
      title: const Text('Usuarios'),
      onTap: (){
        Navigator.pop(context);
        Navigator.pushNamed(context, 'users');
      },
    );
  }
}


class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader( 
      decoration: const BoxDecoration(  
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
      child: Container(),
    );
  }
}