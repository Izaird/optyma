import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:games_services/games_services.dart';
import 'package:optyma_app/presentation/core/player_navigation_menu.dart';


class HomePlayer extends StatelessWidget {

    @override
    Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina principal'),
      ),
      drawer: PlayerNavigationMenu(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Center(
            child: Text('Bienvenido usuario!')
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
              //Navigator.pop(context);
              //Navigator.pushNamed(context, 'leaderboards');
            },
          ),
        ],
      ),
    );
  }
}