import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:optyma_app/application/auth/auth_bloc.dart';

class PlayerNavigationMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    // final relativeHeight = MediaQuery.of(context).size.height;
    return Drawer(
      child: ListView(  
        padding: EdgeInsets.zero,
        children: const [
          Header(),
          InfiniteMode(),
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
        BlocProvider.of<AuthBloc>(context).add(const AuthEvent.signedOut());
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