import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:games_services/games_services.dart';
import 'package:optyma_app/application/game_modes/game_modes_bloc.dart';
import 'package:optyma_app/presentation/core/player_navigation_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePlayer extends StatelessWidget {
  
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
              //Navigator.pop(context);
              //Navigator.pushNamed(context, 'achievements');
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
        ],
      ),
    );
  }
  
  
}

