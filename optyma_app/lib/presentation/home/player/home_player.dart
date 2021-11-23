import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:games_services/games_services.dart';
import 'package:optyma_app/application/game_modes/game_modes_bloc.dart';
import 'package:optyma_app/presentation/core/player_navigation_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePlayer extends StatelessWidget {
  final firebaseAuth = FirebaseAuth.instance;
  final snackBar = const SnackBar(
     content: Text("Se envio el correo para reestaablecer contraseña"),
     duration: Duration(seconds: 15),
     backgroundColor: Colors.green,
   );
    @override
    Widget build(BuildContext context) {
    GamesServices.signIn();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina principal'),
      ),
      drawer: PlayerNavigationMenu(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Text('Bienvenido usuario!' )
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.gamepad, color: Colors.blue),
            title: const Text('Juegos'),
            onTap: (){
              //Navigator.pop(context);
              Navigator.pushNamed(context, 'game-modes');
            },
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.trophy, color: Colors.blue),
            title: const Text('Logros'),
            onTap: (){
              try{
                GamesServices.signIn();
              }
              catch(e){
                print(e);
              }
              GamesServices.showAchievements();
            },
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.table, color: Colors.blue),
            title: const Text('Leaderboards'),
            onTap: (){
              if(GamesServices.isSignedIn==false){
                GamesServices.signIn();
              }
              GamesServices.showLeaderboards(androidLeaderboardID: "CgkIg5u-zPUVEAIQBg");
            },
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.key, color: Colors.blue),
            title: const Text('Resetear contraseña'),
            onTap: (){
              firebaseAuth.sendPasswordResetEmail(email: firebaseAuth.currentUser?.email ?? "mothtotheflame.dev@gmail.com");
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        ],
      ),
    );
  }
  
  
}

